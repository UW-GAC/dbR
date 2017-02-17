context("test_dplyr_connect - unit tests")

test_that("test_dplyr_connect returns an error if the database isn't in the
          .cnf file", {
  #make_temp_cnf is a helper function
  temp_cnf_path <- make_temp_cnf()
  on.exit(unlink(temp_cnf_path))

  expect_error(dplyr_connect("not a database", temp_cnf_path),
               "database not in cnf file", fixed = TRUE)
})

test_that("dplyr_connect returns a MySQLConnection object", {
  con <- dplyr_connect("readonly_test")
  on.exit(lapply(RMySQL::dbListConnections(dbDriver( drv = "MySQL")),
                  dbDisconnect))
  expect_is(con, "src_mysql")
})

test_that("dplyr_connect test connection can find testtable", {
  con <- dplyr_connect ("readonly_test")
  on.exit(rm(con))
  expect_true("testtable" %in% dplyr::src_tbls(con))
})

test_that("dplyr_connect test connection lists correct fields", {
  con <- dplyr_connect("readonly_test")
  on.exit(rm(con))
  expect_true(identical(dplyr::tbl(con, "testtable")$ops$vars,
                        c("field 1", "field 2")))
})
