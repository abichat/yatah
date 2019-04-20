context("Ranks and clades handlers")

lineage1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lineage2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lineage3 <- paste0("k__Bacteria|p__Proteobacteria|c__Betaproteobacteria",
                   "|o__Burkholderiales|f__Comamonadaceae",
                   "|g__Delftia|s__Delftia_unclassified")
lineage4 <- "k__Bac|p__Fir|c__Clos|o__Clost|f__Rumi|g__Subdo|s__Sub_su|t__X_56Z"
lineage5 <- "k__Viruses"
lineages <- c(lineage1, lineage2, lineage3, lineage4, lineage5)

lineage1bis <- "k__Bacteria;p__Verrucomicrobia;c__Verrucomicrobiae"
lineage2bis <- "k__Bacteria;p__Firmicutes;c__Clostridia"
lineagesbis <- c(lineage1bis, lineage2bis)

errormessdepth <- "Lineages don't have the same depth."

#### is_rank() ####

test_that("is_rank() is correct", {
  expect_equal(is_rank(lineages, "class"), c(TRUE, TRUE, FALSE, FALSE, FALSE))
  expect_equal(is_rank(lineages, "order"), c(FALSE, FALSE, FALSE, FALSE, FALSE))
  expect_equal(is_rank(lineages, "sp"), c(FALSE, FALSE, TRUE, FALSE, FALSE))
  expect_equal(is_rank(lineages, "strain"), c(FALSE, FALSE, FALSE, TRUE, FALSE))
  expect_equal(is_rank(lineagesbis, "class", sep = ";"), c(TRUE, TRUE))
})

test_that("is_rank() throws error when needed", {
  expect_error(is_rank(lineages, "OTUs"))
})


#### is_clade() ####

test_that("is_clade() is correct", {
  expect_equal(is_clade(lineages, "Clostridia", "class"),
               c(FALSE, TRUE, FALSE, FALSE, FALSE))
  expect_equal(is_clade(lineagesbis, "Clostridia", "class", sep = ";"),
               c(FALSE, TRUE))
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


#### last_clade() ####

test_that("last_clade() is correct", {
  expect_equal(last_clade(lineages[1:2]),
               c("Verrucomicrobiae", "Clostridia"))
  expect_equal(last_clade(lineagesbis, sep = ";"),
               c("Verrucomicrobiae", "Clostridia"))
  expect_equal(last_clade(lineages, same = FALSE),
               c("Verrucomicrobiae", "Clostridia",
                 "Delftia_unclassified", "X_56Z", "Viruses"))
})

test_that("last_clade() throws error when needed", {
  expect_error(last_clade(lineages, same = TRUE), errormessdepth)
})


#### last_rank() ####

test_that("last_rank() is correct", {
  expect_equal(last_rank(lineages[1:2]),
               c("class", "class"))
  expect_equal(last_rank(lineagesbis, sep = ";"),
               c("class", "class"))
  expect_equal(last_rank(lineages, same = FALSE),
               c("class", "class", "species", "strain", "kingdom"))
})

test_that("last_rank() throws error when needed", {
  expect_error(last_rank(lineages, same = TRUE), errormessdepth)
})

#### all_clades() ####

test_that("all_clades() have the correct output format", {
  expect_is(all_clades(lineages), "character")
  expect_is(all_clades(lineages, simplify = FALSE), "data.frame")
  expect_equal(dim(all_clades(lineages, simplify = FALSE)),
               c(length(all_clades(lineages)), 2))
  expect_equal(colnames(all_clades(lineages, simplify = FALSE)),
               c("clade", "rank"))
})

test_that("all_clades() is correct", {
  expect_equal(all_clades(c(lineage1, lineage2)),
               c("Bacteria", "Clostridia", "Firmicutes", "Verrucomicrobia",
                 "Verrucomicrobiae"))
  expect_equal(all_clades(lineage5), "Viruses")
  expect_equal(all_clades(c(lineage4, lineage5), simplify = FALSE)$clade,
               c("Bac", "Clos", "Clost", "Fir", "Rumi",
                 "Sub_su", "Subdo", "Viruses", "X_56Z"))
  expect_equal(all_clades(c(lineage4, lineage5), simplify = FALSE)$rank,
               c("kingdom", "class", "order", "phylum", "family",
                 "species", "genus", "kingdom", "strain"))
  expect_equal(all_clades(lineage5), "Viruses")
  expect_equal(all_clades(lineagesbis, sep = ";"), all_clades(lineages[1:2]))
  expect_equal(all_clades(lineagesbis, sep = ";", simplify = FALSE),
               all_clades(lineages[1:2], simplify = FALSE))
})
