context("Taxonomy")

lin1 <- "k__Bacteria|p__Verrucomicrobia|c__Verrucomicrobiae"
lin2 <- "k__Bacteria|p__Firmicutes|c__Clostridia"
lin3 <- "k__Bacteria|p__Firmicutes|c__Bacilli"
lineages <- c(lin1, lin2, lin3)
taxtable <- taxtable(lineages)
# plot(taxtree(taxtable))

test_that("taxtree() give the right format", {
  expect_is(taxtree(taxtable), "phylo")
  expect_equal(length(taxtree(taxtable)$tip.label), 3)
  expect_equal(length(taxtree(taxtable)$node.label), 2)
})

test_that("taxtree() is independant from the row orderand duplicated rows ", {
  expect_equal(taxtree(taxtable[3:1, ]), taxtree(taxtable))
  expect_equal(taxtree(taxtable[rep(1:3, 2), ]), taxtree(taxtable))
})

lin4 <- "k__Archaea|p__Euryarchaeota|c__Methanobacteria"
lin5 <- "k__Bacteria|p__Firmicutes|c__Erysipelotrichia"
lineages <- c(lineages, lin4, lin5)
taxtable <- taxtable(lineages)
# plot(taxtree(taxtable))

test_that("options are correct", {
  expect_equal(taxtree(taxtable, root = "X")$node.label[1], "X")
  expect_equal(taxtree(taxtable[c(2, 3, 5), ])$node.label[1], "Firmicutes")
  expect_equal(length(taxtree(taxtable, collapse = FALSE)$node.label), 6)
  expect_equal(max(taxtree(taxtable, lineage_length = 7)$edge.length), 7)
  expect_equal(taxtree(taxtable, collapse = FALSE)$edge.length, rep(1/3, 10))
})

taxtable2 <- taxtable
taxtable2$order <- NA
taxtable2[6:7, ] <- taxtable2[1:2, ]
taxtable2[2, 3] <- NA

test_that("improper taxonomic tables are correcly handled", {
  expect_equal(taxtree(taxtable2), taxtree(taxtable))
})

test_that("taxonomic tables with only one unique row throw errors", {
  expect_error(taxtree(taxtable2[1, ]))
  expect_error(taxtree(taxtable2[c(1, 6), ]))
  expect_error(taxtree(taxtable2[c(1, 2, 6), ]))
})


