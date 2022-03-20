library(devtools)
library(testthat)

#### One time ####

# use_cran_comments()

# use_build_ignore("dev_history.R")

# use_test("previous_outputs")

# use_github_action("pkgdown")

# use_github_action_check_standard()

# use_r("trim")
# use_test("trim")

# use_package_doc()

# badger::badge_last_commit()

# use_test("special_characters")

# use_r("zzz")


#### Repeated ####

devtools::load_all()

devtools::document()
attachment::att_amend_desc()
usethis::use_tidy_description()

# covr::package_coverage()

devtools::spell_check()
# spelling::update_wordlist()

devtools::run_examples()

devtools::test()

prefixer::check_import_from()
prefixer::check_Rd_examples()
prefixer::check_Rd_value()

devtools::check()
goodpractice::gp()

covr::package_coverage()
covr::report()

#### Less often ####

# pkgdown::template_reference()

devtools::install(upgrade = "never")
rmarkdown::render("README.Rmd")
unlink("README.html")

pkgdown::build_site()
unlink(c("pkgdown/", "docs/"), recursive = TRUE)
install(upgrade = "never")

