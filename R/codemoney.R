
#define function to code money


codemoney<-function(input) {
  options(warn=-1)

  #check whether is NA or not even exist
  exist<-function(input){
    if( any(length(input)==0 , is.na(input))) re<-FALSE
    else re<-TRUE
    return(re)
  }
  
  #download usefull functions
  install_r<-function(site,pkg){
    #source R function
    source_https <- function(url, ...) {
      # load package
      require(RCurl)
      
      # parse and evaluate each .R script
      sapply(c(url, ...), function(u) {
        eval(parse(text = getURL(u, followlocation = TRUE, cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))), envir = .GlobalEnv)
      })
    }
    
    #read all the function
    for(i in 1:length(pkg)) {
      source_https(paste0(site,pkg))  
    }
  }
  

  install_r("https://raw.githubusercontent.com/xxxw567/R-Chinese-Word-Processing/master/R/",c("basic_cn.R"))
  
    
  #sum witin wan
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
  #code中文部分和数字部分加
  if (exist(chin)) out<-fenwansum(as.numeric(c(num,chinn)))
  else out<-num[1]
  return(out)
  segment.options(isQuantifierRecognition= TRUE)
  segment.options(isNumRecognition = TRUE)
  options(warn=0)
}
