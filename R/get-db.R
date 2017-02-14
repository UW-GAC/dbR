#' Get a mysql database connection
#'
#' @param dbname the database name (should match descriptor in .cnf file)
#' @param config the path to the .cnf file (incluidng the .cnf file name)
#' @return
#' A database connection
#'
#' @examples
#' conn <- get_db_mysql("testdb", "~/.mysql.cnf")
#'
#' @export

get_db_mysql <- function(dbname, config="~/.mysql.cnf") { #nolint
  if (!dbname %in% list_from_cnf(config)) {
    stop("database not in cnf file")
  }
  db <- RMySQL::dbConnect(RMySQL::MySQL(), default.file = config,
                          group = dbname)
}
