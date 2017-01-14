# RStudio <=> Github sync via auto refreshe pages
During your class you write your code in RStudio and your students try to copy it from the screen projector. There is another way:

* create a GitHub repository
* create an [RMarkdown website](http://rmarkdown.rstudio.com/rmarkdown_websites.html) (I use an `output_dir: "docs"` option in `_site.yml` file) and push to GitHub
* enable [GitHub pages](https://pages.github.com/)
* connect RStudio and GitHub via [ssh key](http://www.datasurg.net/2015/07/13/rstudio-and-github/)
* use `sync` function. It:
  - renders website using path you provide (argument `path`)
  - changes rendered websites to auto refreshe pages (by default it auto refreshes every 5 sec, argument `frequency`)
  - creates a commit using system function `date` (on Linux)

Give a link to your website to your students, so they can follow every step in your .Rmd file. Change your file and `sync`!