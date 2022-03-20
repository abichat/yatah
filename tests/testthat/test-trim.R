lin <- c("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__hhh",
          "k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg|t__",
          "k__aaa|p__bbb|c__ccc|o__",
          "k__aaa|p__bbb|c__ccc|o__|f__|g__|s__|t__",
          "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg|t__",
          "k__",
          "k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg")


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

test_that("trim_common() works", {
  expect_equal(trim_common(lin, remove_void = FALSE),
               c(rep("k__aaa", 5), "k__", "k__aaa"))
  expect_equal(trim_common(lin[-6], remove_void = TRUE),
               c(rep("k__aaa|p__bbb|c__ccc", 6)))
  lin2 <- lin[c(1:2, 5, 7)]
  expect_equal(trim_common(lin2, remove_void = FALSE),
               c(rep("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg", 2),
                 rep("k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg", 2)))
  expect_equal(trim_common(lin2, remove_void = TRUE),
               c(rep("k__aaa|p__bbb|c__ccc|o__ddd|f__eee|g__fff|s__ggg", 2),
                 rep("k__aaa|p__bbb|c__ccc|o__|f__eee|g__fff|s__ggg", 2)))
  expect_equal(trim_common(lin2, remove_void = TRUE, only_tail = FALSE),
               rep("k__aaa|p__bbb|c__ccc", 4))
})
