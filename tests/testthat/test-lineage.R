context("Lineages")

lineage1 <- "k__Bacteria"
lineage2 <- "k__Bacteria|p__Firmicutes"
lineage3 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lineage4 <- "k__Bac|p__Fir|c__Clos|o__Clost"
lineage5 <- "k__Bac|p__Fir|c__Clos|o__Clost|f__Rumi"
lineage6 <- "k__Bac|p__Fir|c__Clos|o__Clost|f__Rumi|g__Subdo"
lineage7 <- "k__Bac|p__Fir|c__Clos|o__Clost|f__Rumi|g__Subdo|s__Sub_su"
lineage8 <- "k__Bac|p__Fir|c__Clos|o__Clost|f__Rumi|g__Subdo|s__Sub_su|t__X_56Z"
lineages <- c(lineage1, lineage2, lineage3, lineage4,
              lineage5, lineage6, lineage7, lineage8)

lineage1bis <- "k__Bacteria"
lineage2bis <- "k__Bacteria;p__Firmicutes"
lineage3bis <- "k__Bacteria;p__Firmicutes;c__Clostridia"
lineage4bis <- "k__Bac;p__Fir;c__Clos;o__Clost"
lineage5bis <- "k__Bac;p__Fir;c__Clos;o__Clost;f__Rumi"
lineagesbis <- c(lineage1bis, lineage2bis, lineage3bis,
                 lineage4bis, lineage5bis)

badlin1 <- "p__Firmicutes|c__Clostridia"
badlin2 <- "k__Bac|p__Fir|o__Clos|c__Clost|f__Rumi"
badlin3 <- "k__Bac|p__Fir|c__Clos|o__Clo|f__Rumi|g__Sub|s__Sub_su|t__X_56Z|a__c"
badlin4 <- "k__Bac|p__Fir|b__Clos|o__Clo|f__Rumi|"
badlin5 <- "k__Bac|c__Clos|o__Clost|f__Rumi"
badlins <- c(badlin1, badlin2, badlin3, badlin4, badlin5)

errorbadlin <- paste0("Your string is not a lineage. Maybe you have specified",
                      " the wrong separator or used special caracters.")

#### is_lineage()

test_that("is_lineage() is correct", {
  expect_equal(is_lineage(lineages), rep(TRUE, 8))
  expect_equal(is_lineage(badlins), rep(FALSE, 5))
  options(yatah_sep = ";")
  expect_equal(is_lineage(lineagesbis), rep(TRUE, 5))
  options(yatah_sep = "\\|")
})


#### error_lineage()

test_that("error_lineage() is correct", {
  expect_silent(error_lineage(lineages))
  options(yatah_sep = ";")
  expect_silent(error_lineage(lineagesbis))
  options(yatah_sep = "\\|")
  expect_error(error_lineage(badlins), errorbadlin)
  expect_error(error_lineage(c(lineages, badlin5)), errorbadlin)
})


#### all functions

test_that("errors are thrown with bad lineages", {
  expect_error(all_clades(c(lineage5, badlin2)), errorbadlin)
  expect_error(is_clade(c(lineage5, badlin2), "Bac"), errorbadlin)
  expect_error(is_rank(c(lineage5, badlin2), "family"), errorbadlin)
  expect_error(last_clade(c(lineage5, badlin2)), errorbadlin)
  expect_error(last_rank(c(lineage5, badlin2)), errorbadlin)
  expect_error(taxtable(c(lineage5, badlin2)), errorbadlin)
})

