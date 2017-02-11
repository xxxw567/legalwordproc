library(devtools)
library(roxygen2)
library(testthat)

#build package
# cd c:/Users/xiayi_000/Documents/GitHub/
#   R CMD INSTALL legalwordproc

#Gen helpfile
site<-"c:/Users/xiayi_000/Documents/GitHub/legalwordproc"
roxygenize(site)
load_all(site)
test(site)
document(site)

#check
check(site)

##########################install
library(devtools)
install_github("xxxw567/legalwordproc")

library(legalwordproc)

############################
# #recode
# setwd(site)
# 
# ap<-rbind(c(1,stri_escape_unicode("零一个")),
#           c(1,stri_escape_unicode("零一")),
#           c(2,stri_escape_unicode("零两个")),
#           c(2,stri_escape_unicode("零两")),
#           c(2,stri_escape_unicode("零二个")),
#           c(2,stri_escape_unicode("零二")),
#           c(3,stri_escape_unicode("零三个")),
#           c(3,stri_escape_unicode("零三")),
#           c(4,stri_escape_unicode("零四个")),
#           c(4,stri_escape_unicode("零四")),
#           c(5,stri_escape_unicode("零五个")),
#           c(5,stri_escape_unicode("零五")),
#           c(6,stri_escape_unicode("零六个")),
#           c(6,stri_escape_unicode("零六")),
#           c(7,stri_escape_unicode("零七个")),
#           c(7,stri_escape_unicode("零七")),
#           c(8,stri_escape_unicode("零八个")),
#           c(8,stri_escape_unicode("零八")),
#           c(9,stri_escape_unicode("零九个")),
#           c(9,stri_escape_unicode("零九")),
#           c(10,stri_escape_unicode("零十个")),
#           c(10,stri_escape_unicode("零十")),
#           c(11,stri_escape_unicode("零十一个")),
#           c(11,stri_escape_unicode("零十一"))
#           )
# colnames(ap)<-colnames(datacorr)
# load("data/datacorr.rda")
# datacorr<-rbind(datacorr,ap)
# save(datacorr,file="data/datacorr.rda",compress=TRUE)
# datacorr$chin<-stri_unescape_unicode(datacorr$chin)
# datacorr$chin<-stri_escape_unicode(datacorr$chin)


