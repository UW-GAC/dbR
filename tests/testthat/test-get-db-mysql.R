context("get_db_mysql - unit tests")

test_that("get_db_mysql returns an error if the database isn't in the .cnf
          file", {
  #make_temp_cnf is a helper function
  temp_cnf_path <- make_temp_cnf()
  on.exit(unlink(temp_cnf_path))

  expect_error(get_db_mysql("not a database", temp_cnf_path),
               "database not in cnf file", fixed = TRUE)
})

test_that("get_db_mysql returns a MySQLConnection object", {
  con <- get_db_mysql("readonly_test")
  on.exit(RMySQL::dbDisconnect(con)) #nolint
  expect_is(con, "MySQLConnection")
})

test_that("get_db_mysql test connection can find testtable", {
  con <- get_db_mysql("readonly_test")
  on.exit(RMySQL::dbDisconnect(con)) #nolint
  expect_true("testtable" %in% RMySQL::dbListTables(con)) #nolint
})

test_that("get_db_mysql test connection lists correct fields", {
  con <- get_db_mysql("readonly_test")
  on.exit(RMySQL::dbDisconnect(con)) #nolint
  expect_true(identical(RMySQL::dbListFields(con, "testtable"), #nolint
                        c("field 1", "field 2")))
})
