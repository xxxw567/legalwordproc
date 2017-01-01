chinntoda<-function (input) {
  #read data in my github
  require(RCurl)
  
  datacorr <-read.csv(text=getURL("https://raw.githubusercontent.com/xxxw567/R-Chinese-Word-Processing/master/R/numtochin.csv"),
                      header=T,fileEncoding = "GBK")
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