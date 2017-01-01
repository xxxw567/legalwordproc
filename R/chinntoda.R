chinntoda<-function (input) {
  
  
  
  datacorr[,1]<-as.integer(datacorr[,1])
  #check whether is NA or not even exist
  exist<-function(input){
    if( any(length(input)==0 , is.na(input))) re<-FALSE
    else re<-TRUE
    return(re)
  }