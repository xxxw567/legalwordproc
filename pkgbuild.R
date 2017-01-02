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
library(readr)
rdada <- read.table("~/Documents/GitHub/legalwordproc/data/rdada.txt",sep = ",",header = TRUE,fileEncoding = "UTF-8")
View(rdada)

