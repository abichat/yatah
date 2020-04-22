context("Trim verbs")


lin10 <- c("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__hhh",
          "k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__",
          "k__aaa|p__bbb|c__ccc|o__",
          "k__aaa|p__bbb|c__ccc|o__|f__|g__|s__|t__",
          "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg|t__",
          "k__")


test_that("trim_void() works", {
  expect_error(trim_void(lin10))
  expect_equal(trim_void(lin10, same = FALSE),
               c("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__hhh",
                 "k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg",
                 "k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc", ""))
})


test_that("trim_rank() works", {
  expect_error(trim_rank(lin10, rank = "class", same = TRUE))
  expect_error(trim_rank(lin10, rank = "OTU", same = FALSE))
  expect_equal(trim_rank(lin10, rank = "class", same = FALSE),
               c("k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc", "k__aaa|p__bbb|c__ccc",
                 "k__aaa|p__bbb|c__ccc", NA))
  expect_equal(trim_rank(lin10, rank = "order", same = FALSE),
               c("k__aaa|p__bbb|c__ccc|o__ddd", "k__aaa|p__bbb|c__ccc|o__ddd",
               "k__aaa|p__bbb|c__ccc|o__", "k__aaa|p__bbb|c__ccc|o__",
               "k__aaa|p__bbb|c__ccc|o__", NA))
})
