#' Check whether a certain word is exist.
#' @param input
#' @param find
#' @return Ture/False
#' @keywords basic
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
#' @param input
#' @param find
#' @return Ture/False
#' @keywords basic
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


is.num_coma<-function(input){
  any(!is.na(as.numeric(input)),input==".")
}

chinntoda<-function (input) {

  if(length(input)>1) stop("more than one string detected!")

  #readatain gethub
  source_GitHubData <-function(url, sep = ",", header = TRUE)
  {
    require(httr)
    request <- GET(url)
    stop_for_status(request)
    handle <- textConnection(content(request, as = 'text'))
    on.exit(close(handle))
    read.table(handle, sep = sep, header = header)
  }

  datacorr<-source_GitHubData("https://raw.githubusercontent.com/xxxw567/R-Chinese-Word-Processing/master/data/numtochin_utf8.txt")

  datacorr[,1]<-as.integer(datacorr[,1])
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


codemoney<-function(input) {
  options(warn=-1)

  #check whether is NA or not even exist
  exist<-function(input){
    if( any(length(input)==0 , is.na(input))) re<-FALSE
    else re<-TRUE
    return(re)
  }
  #within
  calculate_num<-function(input=chinn){
    input <- input[!is.na(input)]
    if (input==0) return(0)
    else {
      pos<-which(input%%10==0)
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
      }
      return(res)
    }
  }

  #sum seperated by WAN
  fenwansum<-function(input) {
    poswan<-which(input==10000)
    if (length(poswan)==0) return(calculate_num(input))
    else {
      wanqian<-vector()
      wanhou<-vector()
      if (poswan==1) {
        wanqian<-1
        wanhou<-input[2:length(input)]
      }
      else if (poswan==length(input)) {
        wanqian<-input[1:(poswan-1)]
        wanhou<-0
      }
      else {
        wanqian<-input[1:(poswan-1)]
        wanhou<-input[(poswan+1):length(input)]
      }
      wanqian<-calculate_num(wanqian)
      wanhou<-calculate_num(wanhou)
      return(wanqian*10000+wanhou)
    }
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
  if (exist(chin)) out<-fenwansum(as.numeric(c(num,chinn)))
  else out<-num[1]
  return(out)
  segment.options(isQuantifierRecognition= TRUE)
  segment.options(isNumRecognition = TRUE)
  options(warn=0)
}



