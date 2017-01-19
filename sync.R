#' Sync RStudio and GitHub via auto refresh pages
#'
#' Takes a path vector, renders the site from Rmd files, changes .html files in the /docs subbderictory to auto refresh pages and push it to GitHub via ssh key.
#' @param path is a path to the derictory with Rmd files
#' @param frequency is a integer that set auto refresh frequency
#' @param exceptions is a vector of names of Rmd files that should stay without auto refresh
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' sync()
#' sync(exceptions = "Lec_1_Course_description.html")
#' sync(exceptions = list.files(pattern="Lec.*\\.html"))
#' @export


sync <- function(path = getwd(), frequency = 5, exceptions = NULL){
  # render site
  setwd(path)
  rmarkdown::render_site()
  
  # if there are exceptions
  if (!is.null(exceptions)){
    files <- setdiff(list.files(pattern=".*\\.html"), exceptions)
  } else {files <- list.files(pattern=".*\\.html")}

  # add a 10 seconds auto refresh
  setwd(paste0(path, "/docs"))
  sapply(files, function(x){
    html <- readLines(x)
    html[8] <- paste0('<meta http-equiv="refresh" content="', frequency, '"/>')
    writeLines(html, x)
    }
  )
  
  # push to github
  system(command = paste0('cd ',
         path,
         '; git add --all; mydate=`date`; git commit -m "$mydate"; git push -u origin master'))
  
  # change the working directory back
  setwd(path)
  }