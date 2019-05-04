context("On load")

test_that("multiplication works", {
  expect_equal(.onLoad()$yatah_sep, "\\|")
})
