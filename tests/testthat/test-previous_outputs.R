context("Previous outputs")
library(dplyr)

lineages1 <- c(
  "k__Bacteria|p__Actinobacteria|c__Actinobacteria|o__Coriobacteriales",
  "k__Bacteria|p__Bacteroidetes|c__Bacteroidia|o__Bacteroidales",
  "k__Bacteria|p__Bacteroidetes|c__Flavobacteriia|o__Flavobacteriales",
  "k__Bacteria|p__Firmicutes|c__Bacilli|o__Bacillales",
  "k__Bacteria|p__Firmicutes|c__Bacilli|o__Lactobacillales",
  "k__Bacteria|p__Firmicutes|c__Clostridia|o__Clostridiales",
  "k__Bacteria|p__Proteobacteria|c__Epsilonproteobacteria|o__Campylobacterales",
  "k__Bacteria|p__Proteobacteria|c__Gammaproteobacteria|o__Enterobacteriales",
  "k__Bacteria|p__Proteobacteria|c__Gammaproteobacteria|o__Pseudomonadales"
)
table1 <- taxtable(lineages1)
tree1 <- taxtree(table1)

lineages2 <-
  abundances %>%
  select(lineages) %>%
  filter(is_clade(lineages, "Gammaproteobacteria"),
         is_rank(lineages, "genus")) %>%
  pull(lineages)

table2 <- taxtable(lineages2)
tree2 <- taxtree(table2)

test_that("outputs do not change over time for data 1", {
  expect_known_value(last_clade(lineages1), "previous_outputs/last_clades1",
                     update = FALSE)
  expect_known_value(all_clades(lineages1, simplify = TRUE),
                     "previous_outputs/all_cladesT1", update = FALSE)
  expect_known_value(all_clades(lineages1, simplify = FALSE),
                     "previous_outputs/all_cladesF1", update = FALSE)
  expect_known_value(table1, "previous_outputs/taxtable1", update = FALSE)
  # Test components of the tree
  expect_known_value(tree1$edge, "previous_outputs/treeedges1",
                     update = FALSE)
  expect_known_value(tree1$node.label, "previous_outputs/treenodes1",
                     update = FALSE)
  expect_known_value(tree1$tip.label, "previous_outputs/treetips1",
                     update = FALSE)
  expect_known_value(tree1$edge.length, "previous_outputs/treelengths1",
                     update = FALSE)
})

test_that("outputs do not change over time for data 2", {
  expect_known_value(last_clade(lineages2), "previous_outputs/last_clades2",
                     update = FALSE)
  expect_known_value(all_clades(lineages2, simplify = TRUE),
                     "previous_outputs/all_cladesT2", update = FALSE)
  expect_known_value(all_clades(lineages2, simplify = FALSE),
                     "previous_outputs/all_cladesF2", update = FALSE)
  expect_known_value(table2, "previous_outputs/taxtable2", update = FALSE)
  # Test components of the tree
  expect_known_value(tree2$edge, "previous_outputs/treeedges2",
                     update = FALSE)
  expect_known_value(tree2$node.label, "previous_outputs/treenodes2",
                     update = FALSE)
  expect_known_value(tree2$tip.label, "previous_outputs/treetips2",
                     update = FALSE)
  expect_known_value(tree2$edge.length, "previous_outputs/treelengths2",
                     update = FALSE)
})
