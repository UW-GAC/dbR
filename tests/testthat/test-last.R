context("test_last() - unit tests")

test_that("last() sends a message", {
  expect_message(last(), regexp = ".*")
})
