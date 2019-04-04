context("Ranks handlers")

lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lineage3 <- paste0("k__Bacteria|p__Proteobacteria|c__Betaproteobacteria",
                   "|o__Burkholderiales|f__Comamonadaceae",
                   "|g__Delftia|s__Delftia_unclassified")
lineage4 <- "k__Bac|p__Fir|c__Clos|o__Clost|f__Rumi|g__Subdo|s__Sub_su|t__X_56Z"
lineage5 <- "k__Viruses"
lineages <- c(lineage1, lineage2, lineage3, lineage4, lineage5)


## is_rank()

test_that("is_rank() is correct", {
  expect_equal(is_rank(lineages, "class"), c(TRUE, TRUE, FALSE, FALSE, FALSE))
  expect_equal(is_rank(lineages, "order"), c(FALSE, FALSE, FALSE, FALSE, FALSE))
  expect_equal(is_rank(lineages, "sp"), c(FALSE, FALSE, TRUE, FALSE, FALSE))
  expect_equal(is_rank(lineages, "strain"), c(FALSE, FALSE, FALSE, TRUE, FALSE))
})

test_that("is_rank() throws error when needed", {
  expect_error(is_rank(lineages, "OTUs"))
})


## is_clade()

test_that("is_clade() is correct", {
  expect_equal(is_clade(lineages, "Clostridia", "class"),
               c(FALSE, TRUE, FALSE, FALSE, FALSE))
  expect_equal(is_clade(lineages, "Verrucomicrobia"),
               c(TRUE, FALSE, FALSE, FALSE, FALSE))
  expect_equal(is_clade(lineages, "Bacteria"),
               c(TRUE, TRUE, TRUE, FALSE, FALSE))
  expect_equal(is_clade(lineages, "Bacter"),
               c(FALSE, FALSE, FALSE, FALSE, FALSE))
})

test_that("is_clade() throws error when needed", {
  expect_error(is_clade(lineages, "Bacteria", "otu"))
  expect_error(is_clade(lineages, "Bacteria", c("class", "phylum")))
  expect_error(is_clade(lineages, c("Bacteria", "Clostridia")))
})


## last_clade()

test_that("last_clade() is correct", {
  expect_equal(last_clade(lineages[1:2]),
               c("Verrucomicrobiae", "Clostridia"))
  expect_equal(last_clade(lineages, same = FALSE),
               c("Verrucomicrobiae", "Clostridia",
                 "Delftia_unclassified", "X_56Z", "Viruses"))
})

test_that("last_clade() throws error when needed", {
  expect_error(last_clade(lineages, same = TRUE))
})


## last_rank()

test_that("last_rank() is correct", {
  expect_equal(last_rank(lineages[1:2]),
               c("class", "class"))
  expect_equal(last_rank(lineages, same = FALSE),
               c("class", "class", "species", "strain", "kingdom"))
})

test_that("last_rank() throws error when needed", {
  expect_error(last_rank(lineages, same = TRUE))
})
