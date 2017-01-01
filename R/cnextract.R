#Extract from "start"+1 to "end" in "input",
cnextract<-function (input,start,end) {
  #load package
  library(Rwordseg)
  insertWords(c(start,end))
  #check the length of input
  if (length(input)!=1) stop("Multiple input detected")
  #seg
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
