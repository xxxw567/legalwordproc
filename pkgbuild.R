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
#recode
# ap<-c(0,stri_escape_unicode("零"))
# datacorr<-rbind(datacorr,ap)
# save(datacorr,file="data/datacorr.rda",compress=TRUE)
# datacorr$chin<-stri_unescape_unicode(datacorr$chin)
# datacorr$chin<-stri_escape_unicode(datacorr$chin)


