#' Check whether a certain word is exist.
#' @param input input chinese sentences
#' @param findit findit with Chinese words
#' @return Reture Ture/False
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'

ischinexist<-function(input,findit){
  #load package
  library(Rwordseg)
  insertWords(findit)
  #do
  temp<-matrix(segmentCN(as.character(input),nature=TRUE,nosymbol = FALSE))
  re<-which(findit %in% temp)>0
  if (length(re)==0) re<-FALSE
  #end
  deleteWords(findit)
  return(re)
}

#' Find the position of a certain Chinese word.
#' @param input input chinese sentences
#' @param findit findit with Chinese words
#' @return Reture number indicate the position of Chinese word, NA if not find
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'


findpos<-function(input,findit) {
  #load package
  library(Rwordseg)
  insertWords(findit)
  #do
  temp<-matrix(segmentCN(as.character(input),nature=TRUE,nosymbol = FALSE))
  pos<-which(temp %in%  findit )
  #end
  deleteWords(findit)
  return(pos)
}

#' Cut the Chinese sentences by given characters.
#' @param input input chinese sentences
#' @param findit  cut by which
#' @return as list
#' @keywords basic
#' @author Xia Yiwei
#' @export
#' @examples
#'
cutsentence<-function(input,findit) {
  #load package
  library(Rwordseg)
  insertWords(findit)
  #do
  pos<-findpos(input,findit)
  if (length(pos)==0) re<-input
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
  deleteWords(findit)
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
    for (i in 1:nchar(paste(chin,collapse=""))){
      chinn[i]<-chinntoda(substr(paste(chin,collapse=""),i,i))
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

#' Translate Chinese number into Arabic number vectorize verison
#' Use recursive method
#' @param input formatted Chinese numer
#' @return numeric
#' @keywords ADV
#' @author Xia Yiwei
#' @export
#' @examples
#'
codemoneyv<-Vectorize(codemoney)

#' Detect whether there is negative adverb in Chinese sentence
#' 不、非、无、未、不曾、没、没有、请勿、不用、无须、并非、毫无、决不、休想、
#' 永不、不要、未尝、未曾、毋、莫、从不、从未、从未有过、尚未、一无、并未、尚无、
#' 从来不、从没、绝非、远非、切莫、永不、休想、绝不、毫不、不必、禁止、忌、拒绝、
#' 杜绝、否、弗、木有
#' @param input formatted Chinese numer
#' @return numeric
#' @keywords ADV
#' @author Xia Yiwei
#' @export
#' @examples
#'
detectnegative<-function(input){
  negativewords<-c("\\u4e0d|\\u672a|\\u6ca1\\u6709|\\u65e0\\u987b|
                   \\u51b3\\u4e0d|\\u4e0d\\u8981|\\u6bcb|\\u4ece\\u672a|
                   \\u4e00\\u65e0|\\u4ece\\u6765\\u4e0d|\\u8fdc\\u975e|\\u4f11\\u60f3|
                   \\u4e0d\\u5fc5|\\u62d2\\u7edd|\\u5f17|\\u975e|\\u4e0d\\u66fe|
                   \\u8bf7\\u52ff|\\u5e76\\u975e|\\u4f11\\u60f3|\\u672a\\u5c1d|
                   \\u83ab|\\u4ece\\u672a\\u6709\\u8fc7|\\u5e76\\u672a|\\u4ece\\u6ca1|
                   \\u5207\\u83ab|\\u7edd\\u4e0d|\\u7981\\u6b62|\\u675c\\u7edd|
                   \\u6728\\u6709|\\u65e0|\\u6ca1|\\u4e0d\\u7528|\\u6beb\\u65e0|
                   \\u6c38\\u4e0d|\\u672a\\u66fe|\\u4ece\\u4e0d|\\u5c1a\\u672a|
                   \\u5c1a\\u65e0|\\u7edd\\u975e|\\u6c38\\u4e0d|\\u6beb\\u4e0d|
                   \\u5fcc|\\u5426")
  library("stringi")
  ascinput<-stri_escape_unicode(input)
  nega<-grepl(negativewords, ascinput)
  return(nega)
}

#' Cut sentence based on given characters vector A and keep the sentences contains vector B
#' @param input formatted Chinese numer
#' @param findit sentence seperator
#' @param sep sentence seperator
#' @keywords ADV
#' @author Xia Yiwei
#' @export
#' @examples
#'
keepselect<-function(input,findit,sep=c("，","。")){
  cutresult<-cutsentence(input,sep)
  exist<- sapply(cutresult,function(x){all(ischinexist(x,findit))})
  bothcon<-cutresult[which(exist %in% TRUE)]
  return(bothcon)
}
