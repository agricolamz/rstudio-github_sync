#' Sync RStudio and GitHub via auto refreshe pages
#'
#' Takes a path vector, renders the site from Rmd files, changes .html files in the /docs subbderictory to auto refreshe pages and push it to GitHub via ssh key.
#' @param x character vector of the languoids (can be written in lower case)
#' @author George Moroz <agricolamz@gmail.com>
#' @seealso \code{\link{aff.lang}}, \code{\link{country.lang}}, \code{\link{iso.lang}}, \code{\link{lat.lang}}, \code{\link{long.lang}}
#' @examples
#' area.lang("Adyghe")
#' area.lang(c("Adyghe", "Aduge"))
#' @export


sync <- function(path, frequency = 5){
  # render site
  setwd(path)
  rmarkdown::render_site()
  
  # add a 10 seconds auto refresh
  setwd(paste0(path, "/docs"))
  sapply(list.files(pattern="*.html"), function(x){
    html <- readLines(x)
    html[8] <- paste0('<meta http-equiv="refresh" content="', frequency, '"/>')
    writeLines(html, x)
    }
  )
  # commit on github
  system(command = paste0('cd ',
         path,
         '; git add --all; mydate=`date`; git commit -m "$mydate"; git push -u origin master'))
  }