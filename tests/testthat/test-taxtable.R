lin1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lin2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lin3 <- "k__Bacteria|p__Firmicutes|c__Bacilli"

lin4 <- "k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales"
lin5 <- "k__Bacteria|p__Bacteroidetes|c__Bacteroidia|o__Bacteroidales"
lin6 <- "k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Coriobacteriales"

lineages1 <- c(lin1, lin2, lin3)
lineages2 <- c(lin4, lin5, lin6)

errormessdepth <- "Lineages don't have the same depth."

####

test_that("taxtable() is correct", {
  expect_equal(taxtable(lineages1)$kingdom, rep("Bacteria", 3))
  expect_equal(taxtable(lineages1)$phylum,
               c("Verrucomicrobia", rep("Firmicutes", 2)))
  expect_equal(taxtable(lineages1)$class,
               c("Verrucomicrobiae", "Clostridia", "Bacilli"))
  expect_equal(taxtable(lineages2)$order,
               c("Lactobacillales", "Bacteroidales", "Coriobacteriales"))
})


lin7 <- "k__Bacteria|p__Firmicutes"
lineages3 <- c(lin6, lin7)

test_that("taxtable() throws error when needed", {
  expect_error(taxtable(lineages3))
  expect_error(taxtable(c(lin3, lin4)), errormessdepth)
})

lin1bis <- "k__Bacteria;p__Verrucomicrobia;c__Verrucomicrobiae"
lin2bis <- "k__Bacteria;p__Firmicutes;c__Clostridia"
lin3bis <- "k__Bacteria;p__Firmicutes;c__Bacilli"
lineages1bis <- c(lin1bis, lin2bis, lin3bis)

test_that("taxtable() works with other separators", {
  temmp_taxtable <- taxtable(lineages1)
  options(yatah_sep = ";")
  expect_equal(taxtable(lineages1bis), temmp_taxtable)
  options(yatah_sep = "\\|")
})

lin8 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lin9 <- "k__Bacteria|p__|c__Clostridia"
lin10 <- "k__Bacteria|p__Firmicutes|c__"
lin11 <- "k__Bacteria|p__|c__"

test_that("taxtable() works with void ranks", {
  taxtable_void <- taxtable(c(lin8, lin9, lin10, lin11))
  taxtable_void_bis <- taxtable(c(lin10, lin11))
  expect_equal(taxtable_void$phylum[c(2, 4)], c("", ""))
  expect_equal(taxtable_void$class[c(3, 4)], c("", ""))
  expect_equal(taxtable_void_bis$class, c("", ""))
})
