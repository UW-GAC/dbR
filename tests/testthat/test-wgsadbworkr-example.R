context("test_wgsadbworkr_example() - unit tests")

test_that("wgsadbworkr_example() returns an error if bad filename", {
  expect_error(wgsadbworkr_example("bad_file"), "no file found")
})

test_that("wgsadbworkr_example() returns a path", {
  expect_match(wgsadbworkr_example("fr_5_config.tsv"),
    regexp = ".+fr_5_config.tsv")
})
