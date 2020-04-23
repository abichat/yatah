context("Trim verbs")


lin <- c("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__hhh",
          "k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__",
          "k__aaa|p__bbb|c__ccc|o__",
          "k__aaa|p__bbb|c__ccc|o__|f__|g__|s__|t__",
          "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg|t__",
          "k__", "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg")


test_that("trim_void() works", {
  expect_error(trim_void(lin))
  expect_equal(trim_void(lin, same = FALSE),
               c("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__hhh",
                 "k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg",
                 "k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc", "", "k__aaa|p__bbb|c__ccc"))
  expect_equal(trim_void(lin, same = FALSE, only_tail = TRUE),
               c("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__hhh",
                 "k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg",
                 "k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg", "",
                 "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg"))
})


test_that("trim_rank() works", {
  expect_error(trim_rank(lin, rank = "class", same = TRUE))
  expect_error(trim_rank(lin, rank = "OTU", same = FALSE))
  expect_equal(trim_rank(lin, rank = "class", same = FALSE),
               c("k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc", NA,
                 "k__aaa|p__bbb|c__ccc"))
  expect_equal(trim_rank(lin, rank = "order", same = FALSE),
               c("k__aaa|p__bbb|c__ccc|o__ddd", "k__aaa|p__bbb|c__ccc|o__ddd",
               "k__aaa|p__bbb|c__ccc|o__", "k__aaa|p__bbb|c__ccc|o__",
               "k__aaa|p__bbb|c__ccc|o__", NA,
               "k__aaa|p__bbb|c__ccc|o__"))
})
