Legal document processing
================
Xia YIwei, Nemo
Sunday, January 01, 2017

Chinese legal documents processing
==================================

In the year 2014, the Chinese supreme people's court has release a **[document](http://www.chinacourt.org/article/detail/2013/11/id/1152212.shtml)** to collect and publish all the sentence documents made by court at each level in China.

The goal of current R package(functions) is tried to develop some useful tools to analyzing those Chinese document.

Current R package depends on [Rwordseg](https://github.com/lijian13/Rwordseg) package made by Lijian, please install the package before make full use of the current package.

1.Websites of legal documents
-----------------------------

-   [Offical website](http://wenshu.court.gov.cn/)
-   [OpenLaw](http://openlaw.cn/)

2.Aims
------

-   Develop a useful R package process the Chinese characters in Legal documents
-   Other types of Chinese documents

3.Install this package
----------------------

``` r
library(devtools)
install_github("xxxw567/legalwordproc")
library(legalwordproc)
```

4.Developed functions
---------------------

See the ?functions for more details

-   chinntoda
    Translate a single Chinse Date or Chinese number into Arabic number
-   cnextract
    Cut a chinese sentence based on a given start and end
-   codemoney
    Translate Chinese number into Arabic number
-   cutsentence
    Cut the Chinese sentences by given characters
-   findpos
    Find the position of a certain Chinese word.
-   is.num\_coma
    Detech whether a given chinese word is numeric or "." \* ischinexist
    Check whether a certain word is exist.

### Some examples

-   Cut a chinese sentence based on a given start and end

``` r
cnextract("判处有期徒刑十二年,缓刑一年","判处",",")
```

    ## [1] "有期徒刑" "十二年"   ","

-   Chinese words to date/number

``` r
chinntoda("五")
```

    ## [1] 5

``` r
chinntoda("一年")
```

    ## [1] 12

``` r
chinntoda("one")
```

    ## [1] "one"

-   Convert Chinese number to Arabic Number
    &gt; 这个有点难,其实交给其他软件做更好

``` r
a<-"181208900.00"
b<-"三十万"
c<-"45万"
d<-"5.9万"
e<-"三千余"
f<-"6万余"
g<-"3百万"
h<-"310万"
i<-"300000余"
j<-"3.98万"
k<-"九万"
l<-"壹佰万"
m<-"三十三万"
n<-"三百三十三万"
o<-"三千三百三十三万"
p<-"三千三百三十三万四千五百二十九"
q<-"五点九万"
r<-"五千零三万"

matrix(sapply(c(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r),codemoney))
```

    ##            [,1]
    ##  [1,] 181208900
    ##  [2,]    300000
    ##  [3,]    450000
    ##  [4,]     59000
    ##  [5,]      3000
    ##  [6,]     60000
    ##  [7,]   3000000
    ##  [8,]   3100000
    ##  [9,]    300000
    ## [10,]     39800
    ## [11,]     90000
    ## [12,]   1000000
    ## [13,]    330000
    ## [14,]   3330000
    ## [15,]  33330000
    ## [16,]  33334529
    ## [17,]     59000
    ## [18,]  50030000

-   Cut the Chinese sentences by given characters

``` r
cutsentence ("本院认为，被告人王兴玖、梅潋耀身为安全管理人员，在生产作业中违反安全管理规定，不认真履行职责、发生重大安全事故，致一人死亡，其行为均已构成重大责任事故罪。公诉机关指控的事实、罪名成立，予以确认。",c("，","。"))
```

    ## [[1]]
    ## [1] "本"   "院"   "认为" "，"  
    ## 
    ## [[2]]
    ##  [1] "，"     "被告人" "王"     "兴"     "玖"     "、"     "梅"    
    ##  [8] "潋"     "耀"     "身"     "为"     "安全"   "管理"   "人员"  
    ## [15] "，"    
    ## 
    ## [[3]]
    ##  [1] "，"   "在"   "生产" "作业" "中"   "违反" "安全" "管理" "规定" "，"  
    ## 
    ## [[4]]
    ##  [1] "，"   "不"   "认真" "履行" "职责" "、"   "发生" "重大" "安全" "事故"
    ## [11] "，"  
    ## 
    ## [[5]]
    ## [1] "，"   "致"   "一"   "人"   "死亡" "，"  
    ## 
    ## [[6]]
    ##  [1] "，"       "其"       "行为"     "均"       "已"       "构成"    
    ##  [7] "重大"     "责任事故" "罪"       "。"      
    ## 
    ## [[7]]
    ##  [1] "。"   "公诉" "机关" "指控" "的"   "事实" "、"   "罪名" "成立" "，"  
    ## 
    ## [[8]]
    ## [1] "，"   "予以" "确认" "。"  
    ## 
    ## [[9]]
    ## [1] "。"

5.Useful links
--------------

-   [how to source file in GitHub](https://tonybreyal.wordpress.com/2011/11/24/source_https-sourcing-an-r-script-from-github/)
-   [how to download data from GitHub](https://github.com/opetchey/RREEBES/wiki/Reading-data-and-code-from-an-online-github-repository)
-   [inroduction of Rmarkdown](http://rmarkdown.rstudio.com/?version=0.98.1103&mode=desktop)
-   [Rmarkdown chectsheet](http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf)
-   [RStudio+Markdown+Pandoc](http://www.jianshu.com/p/a97b4a9f6d5b)

-   [how to write R package](http://cos.name/2011/05/write-r-packages-like-a-ninja/)
-   [write R package1\_2013](http://blog.fens.me/r-package-faster/)
-   [write R package2\_2013](http://blog.fens.me/r-build-package/)
