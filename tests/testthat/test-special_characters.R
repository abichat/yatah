lin <- c("k__Aaa|p__Bbb|c__Ccc|o__Ddd",
         "k__Aaa|p__Bbb|c__Ccc|o__Ddd0123456789", # numbers
         "k__Aaa|p__Bbb|c__Cc-c|o__Eee-e", # hyphen
         "k__Aaa|p__Bbb|c__Cc-c|o__Eee", # hyphen
         "k__Aaa|p__Bb_b|c__Ff_f|o__Fff_f", # underscore
         "k__Aaa|p__Bbb|c__H.hh|o__Ii.i", # dot
         "k__Aaa|p__Bbb|c__H.hh|o__J...jj", # multiple dots
         "k__Aaa|p__Bbb|c__K[kk]k|o__Lll[l]", # brackets
         "k__Aaa|p__Ccc|c__Ddd|o__Kk0._]_[._-k") # everything + Ccc in new rank

len <- length(lin)


test_that("is_* functions can handle special charachters", {
  expect_equal(is_lineage(lin), rep(TRUE, len))
  expect_equal(is_rank(lin, "order"), rep(TRUE, len))
  expect_equal(is_rank(lin, "species"), rep(FALSE, len))
  expect_equal(is_clade(lin, "Bbb"),
               c(rep(TRUE, 4), FALSE, rep(TRUE, 3), FALSE))
  expect_equal(is_clade(lin, "Ccc", rank = "phylum"), c(rep(FALSE, 8), TRUE))
})


test_that("extractions functions can handle special charachters", {
  expect_equal(last_clade(lin),
               c("Ddd", "Ddd0123456789", "Eee-e", "Eee", "Fff_f", "Ii.i",
                 "J...jj", "Lll[l]", "Kk0._]_[._-k"))
  expect_equal(last_rank(lin), rep("order", len))
  expect_equal(all_clades(lin),
               c("Aaa", "Bb_b", "Bbb", "Cc-c", "Ccc", "Ddd",
                 "Ddd0123456789", "Eee", "Eee-e", "Ff_f", "Fff_f", "H.hh",
                 "Ii.i", "J...jj", "K[kk]k", "Kk0._]_[._-k", "Lll[l]"))
  expect_equal(all_clades(lin, simplify = FALSE)$clade,
               c("Aaa", "Bb_b", "Bbb", "Cc-c", "Ccc", "Ccc", "Ddd", "Ddd",
                 "Ddd0123456789", "Eee", "Eee-e", "Ff_f", "Fff_f", "H.hh",
                 "Ii.i", "J...jj", "K[kk]k", "Kk0._]_[._-k", "Lll[l]"))
})


test_that("trim functions can handle special charachters", {
  expect_equal(trim_rank(lin, "order"), lin)
  expect_equal(trim_rank(lin, "species"), rep(NA_character_, len))
  expect_equal(trim_rank(lin, "class"),
               c("k__Aaa|p__Bbb|c__Ccc", "k__Aaa|p__Bbb|c__Ccc",
                 "k__Aaa|p__Bbb|c__Cc-c", "k__Aaa|p__Bbb|c__Cc-c",
                 "k__Aaa|p__Bb_b|c__Ff_f", "k__Aaa|p__Bbb|c__H.hh",
                 "k__Aaa|p__Bbb|c__H.hh",  "k__Aaa|p__Bbb|c__K[kk]k",
                 "k__Aaa|p__Ccc|c__Ddd"))
})

table <- taxtable(lin)
orders <- sort(unique(last_clade(lin))) # ok bc no duplicated order names
clades <- all_clades(lin)


test_that("taxtable can handle special charachters", {
  expect_equal(sort(table$order), orders)
})

tree <- taxtree(table)

test_that("taxtree can handle special charachters", {
  expect_equal(sort(tree$tip.label), orders)
  expect_true(all(tree$node.label %in% clades))
})
