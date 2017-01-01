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


