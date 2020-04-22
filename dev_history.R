library(devtools)
library(testthat)

#### One time ####

# use_cran_comments()

# use_build_ignore("dev_history.R")

# use_test("previous_outputs")

# use_github_action("pkgdown")

# use_github_action_check_standard()



#### Repeated ####

load_all()

document()
attachment::att_to_description()
use_tidy_description()

# covr::package_coverage()

spell_check()
# spelling::update_wordlist()

run_examples()

test()

check()
goodpractice::gp()


#### Less often ####

# pkgdown::template_reference()

install(upgrade = "never")
rmarkdown::render("README.Rmd")
unlink("README.html")
pkgdown::build_site()
unlink(c("pkgdown/", "docs/"), recursive = TRUE)
install(upgrade = "never")

