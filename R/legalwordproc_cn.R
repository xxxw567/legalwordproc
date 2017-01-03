#' Check whether a certain word is exist.
#' @param input input chinese sentences
#' @param find find with Chinese words
#' @return Reture Ture/False
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'

ischinexist<-function(input,find){
  #load package
  library(Rwordseg)
  insertWords(find)
  #do
  temp<-matrix(segmentCN(as.character(input),nature=TRUE,nosymbol = FALSE))
  re<-which(find %in% temp)>0
  if (length(re)==0) re<-FALSE
  #end
  deleteWords(find)
  return(re)
}

#' Find the position of a certain Chinese word.
#' @param input input chinese sentences
#' @param find find with Chinese words
#' @return Reture number indicate the position of Chinese word, NA if not find
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'


findpos<-function(input,find) {
  #load package
  library(Rwordseg)
  insertWords(find)
  #do
  temp<-matrix(segmentCN(as.character(input),nature=TRUE,nosymbol = FALSE))
  pos<-which(temp %in%  find )
  #end
  deleteWords(find)
  return(pos)
}

#' Cut the Chinese sentences by given characters.
#' @param input input chinese sentences
#' @param find  cut by which
#' @return as list
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'
cutsentence<-function(input,find) {
  #load package
  library(Rwordseg)
  insertWords(find)
  #do
  pos<-findpos(input,find)
  if (length(pos)==0) re<-NA
  else {
    nsplit<-length(pos)+1
    temp<-matrix(segmentCN(as.character(input),nature=TRUE,nosymbol = FALSE))
    n<-nrow(temp)
    re<-list()
    for(i in 1:nsplit) {
      if (i==1) startpot<-1
      else startpot<-pos[i-1]
      if (i==nsplit) endpot<-n
      else endpot<-pos[i]
      re[[i]]<-temp[startpot:endpot,]
    }
  }
  #end
  deleteWords(find)
  return(re)
}


#' Detech whether a given chinese word is numeric or "."
#' @param input input chinese sentences
#' @return TRUE or FALSE
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'
is.num_coma<-function(input){
  any(!is.na(as.numeric(input)),input==".")
}

#' Translate a single Chinse Date or Chinese number into Arabic number
#' @param input input chinese sentences
#' @return numeric
#' @keywords ADV
#' @author Xia Yiwei
#' @export
#' @examples
#'
chinntoda<-function (input) {

  if(length(input)>1) stop("more than one string detected!")

  #readatain gethub
  library("stringi")
  datacorr$chin<-stri_unescape_unicode(datacorr$chin)
  datacorr[,1]<-as.numeric(datacorr[,1])
  #check whether is NA or not even exist
  exist<-function(input){
    if( any(length(input)==0 , is.na(input))) re<-FALSE
    else re<-TRUE
    return(re)
  }
  #doing
  if (exist(input)) {
    if (input %in% datacorr[,2]) {
      out<-as.numeric(datacorr[which( datacorr[,2] %in% input),1])
    }
    else {
      out<-input
    }
  }
  else out<-input
  return(out)
}

#' Cut a chinese sentence based on a given start and end
#' @param input input chinese sentences
#' @param start starting words
#' @param end ending words
#' @return list
#' @keywords ADV
#' @author Xia Yiwei
#' @export
#' @examples
#'
cnextract<-function (input,start,end) {
  #load package
  library(Rwordseg)
  insertWords(c(start,end))
  #check the length of input
  if (length(input)!=1) stop("Multiple input detected")
  #seg
  wordseg<-matrix(segmentCN(input,nature=TRUE,nosymbol = FALSE))
  if (sum(start %in% wordseg)) {
    startpot<- which(wordseg %in% start)[1]
    if ( sum(end %in%  wordseg)) {
      endpot<-which(wordseg %in% end)
      #all endpot less than start pot
      if (all(endpot<startpot)) {endpot<-length(wordseg)}
      else {endpot<-min(endpot[endpot>startpot])}
    }
    else {endpot<-length(wordseg)}
    startpot<-startpot+1
    youqisentence<-wordseg[startpot:endpot]
    youqisentence<-paste(youqisentence,sep = "")
    return(youqisentence)
  }
  else {return(character(0))}
  deleteWords(c(start,end))
}


#' Translate Chinese number into Arabic number 2nd version
#' Use recursive method
#' @param input formatted Chinese numer
#' @return numeric
#' @keywords ADV
#' @author Xia Yiwei
#' @export
#' @examples
#'
codemoney<-function(input) {
  options(warn=-1)

  #check whether is NA or not even exist
  exist<-function(input){
    if( any(length(input)==0 , is.na(input))) re<-FALSE
    else re<-TRUE
    return(re)
  }
  #define sumit
  sumit<-function(input) {
    #define split function
    splitat <- function(x, pos,ret=1) {
      out<-list()
      if (length(x)==1) {out[[1]]=1;out[[2]]<-ret}
      else if(pos==1)   {out[[1]]=1;out[[2]]<-x[2:length(x)]}
      else if (pos==length(x))  {out[[1]]=x[1:(pos-1)];out[[2]]<-ret}
      else {
        out[[1]]<-x[1:(pos-1)]
        out[[2]]<-x[(pos+1):length(x)]
      }
      return(out)
    }

    #define inner sum
    innersum<-function(input){
      pos<-which(input%%10==0 )
      if (length(pos)==0) res<-input
      else {
        re<-list()
        if( max(which(input%%10==0))==length(input)) loopn<-length(pos)
        else loopn<-length(pos)+1
        for(i in 1:loopn) {
          if (i==1) startpot<-1
          else startpot<-pos[i-1]+1
          if (i==loopn) endpot<-length(input)
          else endpot<-pos[i]
          if (startpot<=endpot) re[[i]]<-input[startpot:endpot]
          else re[[i]]<-input[endpot]
        }
        res<-sum(sapply(re,prod,na.rm = TRUE))
        return(res)
      }
    }
    #calcualte_sum
    calculate_num<-function(input){
      input <- input[!is.na(input)]
      if (input==0) return(0)
      else {
        if (0.1 %in% input) {
          out<-splitat(input,which(input==0.1))
          res<-sum(innersum(out[[1]]),0.1*out[[2]])
        }
        else  res<-innersum(input)
        return(res)
      }
    }
    #split yi
    if (length(which(input==100000000))!=0) {
      part<-splitat(input,which(input==100000000),ret=0)
      return(sumit(part[[1]])*100000000+sumit(part[[2]]))
    }
    #split wan
    if (length(which(input==10000))!=0) {
      part<-splitat(input,which(input==10000),ret=0)
      return(sumit(part[[1]])*10000+sumit(part[[2]]))
    }
    return(calculate_num(input))
  }
  #start doing
  require(Rwordseg)
  segment.options(isNumRecognition = FALSE)
  segment.options(isQuantifierRecognition= FALSE)
  segword<-segmentCN(input,nosymbol = FALSE)
  detect<-sapply(segword,is.num_coma)
  #differentiate chinese character and non chinse
  nochin<-names(detect)[detect==TRUE]
  chin<-names(detect)[detect==FALSE]
  num<-vector()
  chinn<-vector()
  #code non chinese
  if (exist(nochin)) num<-as.numeric(paste(nochin,collapse=""))
  else num<-integer(0)
  #code chinese
  if (exist(chin)) {
    for (i in 1:length(chin)){
      chinn[i]<-chinntoda(chin[i])
    }
    temp<-sapply(chinn,is.num_coma)
    chinn<-as.numeric(chinn[temp==TRUE])
  }
  else chinn<-integer(0)
  #code produce chinese part and english part
  if (exist(chin)) out<-sumit(as.numeric(c(num,chinn)))
  else out<-num[1]
  return(out)
  segment.options(isQuantifierRecognition= TRUE)
  segment.options(isNumRecognition = TRUE)
  options(warn=0)
}



