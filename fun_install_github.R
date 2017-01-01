fun_install_github <- function (repo = "theBioBucket-Archives",
                                username = "gimoya", 
                                branch = "master") 
 {require(RCurl)
 message("\nInstalling ", repo, " R-functions from user ", username)
 name <- paste(username, "-", repo, sep = "")
 url <- paste("https://github.com/", username, "/", repo,
              sep = "")
 zip_url <- paste("https://nodeload.github.com/", username,
                  "/", repo, "/zipball/", branch, sep = "")
 src <- file.path(tempdir(), paste(name, ".zip", sep = ""))
 content <- getBinaryURL(zip_url, .opts = list(followlocation = TRUE,
                                               ssl.verifypeer = FALSE))
 writeBin(content, src)
 on.exit(unlink(src), add = TRUE)
 repo_name <- basename(as.character(unzip(src, list = TRUE)$Name[1]))
 out_path <- file.path(tempdir(), repo_name)
 unzip(src, exdir = tempdir())
 on.exit(unlink(out_path), add = TRUE)
 fun.path <- dir(paste(out_path, "/R/Functions/", sep = ""), full.names = T)
 for (i in 1:length(fun.path)) {
   source(fun.path[i])
   cat("\n Sourcing function: ", dir(paste(out_path, "/R/Functions/", sep = ""))[i])}
 cat("\n")
}


