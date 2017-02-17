#' Get a mysql database connection
#'
#' @param dbname the database name (should match descriptor in .cnf file)
#' @param config path to the .cnf file, incluidng file name. Default 
#'   ~/.mysql.cnf
#' @return A database connection
#'
#' @examples
#' con <- get_db_mysql("testdb")
#' con <- get_db_mysql("testdb", config = "~/.custom.cnf")
#'
#' dbListFields(con, "testtable")
#'
#' @export

get_db_mysql <- function(dbname, config = "~/.mysql.cnf") { #nolint
  if (!dbname %in% list_from_cnf(config)) {
    stop("database not in cnf file")
  }
  db <- RMySQL::dbConnect(RMySQL::MySQL(),
                          default.file = config,
                          group = dbname)
}

#' Get a dplyr sql src object, the mysql database
#'
#' @param dbname the database name (should match descriptor in .cnf file)
#' @param config path to the .cnf file, including file name. Default
#'  ~/.mysql.cnf
#' @return a dplyr sql src object
#'
#' @examples
#' con <- dplyr_connect("testdb")
#' con <- dplyr_connect("testdb", config = "~/.custom.cnf")
#'
#' dplyr_table <- tbl(con, "testtable")
#'
#' @export

dplyr_connect <- function(dbname, config = "~/.mysql.cnf") { #nolint
  if (!dbname %in% list_from_cnf(config)) {
    stop("database not in cnf file")
  }
  con <- dplyr::src_mysql(dbname = NULL,
                          host = NULL,
                          password = NULL,
                          user = NULL,
                          default.file = config,
                          group = dbname)
}
