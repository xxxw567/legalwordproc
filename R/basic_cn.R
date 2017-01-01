
#basic functions

#whether a character is exist
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

#define function to find the position
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


#define function to cut based on given characters
cutsentence<-function(input,find=c("�⳥","Ԫ")) {
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



#define function keep onlydefined 
cutsentence<-function(input,find=c("�⳥","Ԫ")) {
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


#check whether it is numeric or comma
is.num_coma<-function(input){
  any(!is.na(as.numeric(input)),input==".") 
}
