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