context("list_from_cnf - unit tests")

test_that("list_from_cnf returns a list from a .cnf file", {
  #make_temp_cnf is a helper function
  temp_cnf_path <- make_temp_cnf()
  on.exit(unlink(temp_cnf_path)) # tidy up

  expect_true(is.list(list_from_cnf(temp_cnf_path)))
})

test_that("list_from_cnf returns the expected list from a .cnf file", {
  temp_cnf_path <- make_temp_cnf()
  on.exit(unlink(temp_cnf_path))

  return_expected <- as.list(c("test_connection_1", "test_connection_2"))
  expect_identical(list_from_cnf(temp_cnf_path), return_expected)
})
