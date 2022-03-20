test_that("Loading works", {
  expect_equal(.onLoad()$yatah_sep, "\\|")
})
