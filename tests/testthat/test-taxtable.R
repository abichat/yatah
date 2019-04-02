context("Taxonomic table")

lin1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lin2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lin3 <- "k__Bacteria|p__Firmicutes|c__Bacilli"

lin4 <- "k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales"
lin5 <- "k__Bacteria|p__Bacteroidetes|c__Bacteroidia|o__Bacteroidales"
lin6 <- "k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Coriobacteriales"

lin7 <- "k__Bacteria|p__Firmicutes"

lineages1 <- c(lin1, lin2, lin3)
lineages2 <- c(lin4, lin5, lin6)
lineages3 <- c(lin6, lin7)

test_that("taxtable() is correct", {
  expect_equal(as.character(taxtable(lineages1)$kingdom), rep("Bacteria", 3))
  expect_equal(as.character(taxtable(lineages1)$phylum),
               c("Verrucomicrobia", rep("Firmicutes", 2)))
  expect_equal(as.character(taxtable(lineages1)$class),
               c("Verrucomicrobiae", "Clostridia", "Bacilli"))
  expect_equal(as.character(taxtable(lineages2)$order),
               c("Lactobacillales", "Bacteroidales", "Coriobacteriales"))
})

test_that("taxtable() throws error when needed", {
  expect_error(taxtable(lineages3))
})
