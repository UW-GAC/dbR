#' List database connections available in a .cnf file
#'
#' @param path the path to the .cnf file (incluidng the .cnf file name)
#' @return
#' A list of database connections listed in the .cnf file
#'
#' @examples
#' databases <- list_from_cnf('~/.mysql.cnf')
#'
#' @export

list_from_cnf <- function(path){
  cnf_contents <- readLines(path)
  bracketed_lines <- grep("\\[", cnf_contents, value = TRUE)
  ugly_databases <- bracketed_lines[-grep("client", bracketed_lines)]
  make_pretty <- function(ugly_string) {
    pretty_string <- sub(".*\\[", "", ugly_string)
    pretty_string <- substr(pretty_string, 1, nchar(pretty_string) - 1)
  }
  lapply(ugly_databases, make_pretty)
}
