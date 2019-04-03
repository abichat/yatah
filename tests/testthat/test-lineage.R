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

badlin1 <- "p__Firmicutes|c__Clostridia"
badlin2 <- "k__Bac|p__Fir|o__Clos|c__Clost|f__Rumi"
badlin3 <- "k__Bac|p__Fir|c__Clos|o__Clo|f__Rumi|g__Sub|s__Sub_su|t__X_56Z|a__c"
badlin4 <- "k__Bac|p__Fir|b__Clos|o__Clo|f__Rumi|"
badlins <- c(badlin1, badlin2, badlin3, badlin4)

test_that("is_lineage() is correct", {
  expect_equal(is_lineage(lineages), rep(TRUE, 8))
  expect_equal(is_lineage(badlins), rep(FALSE, 4))
})
