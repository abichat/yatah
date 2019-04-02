context("Levels handlers")

lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lineage3 <- paste0("k__Bacteria|p__Proteobacteria|c__Betaproteobacteria",
                   "|o__Burkholderiales|f__Comamonadaceae",
                   "|g__Delftia|s__Delftia_unclassified")
lineages <- c(lineage1, lineage2, lineage3)
# Need to add a strain level

test_that("is_level() is correct", {
  expect_equal(is_level(lineages, "class"), c(TRUE, TRUE, FALSE))
  expect_equal(is_level(lineages, "order"), c(FALSE, FALSE, FALSE))
  expect_equal(is_level(lineages, "sp"), c(FALSE, FALSE, TRUE))
})

test_that("is_level() throw error", {
  expect_error(is_level(lineages, "OTUs"))
})


test_that("last_level() is correct", {
  expect_equal(last_level(lineages[1:2]),
               c("Verrucomicrobiae", "Clostridia"))
  expect_equal(last_level(lineages, same = FALSE),
               c("Verrucomicrobiae", "Clostridia", "Delftia_unclassified"))
})

test_that("last_level() throw error", {
  expect_error(last_level(lineages, same = TRUE))
})
