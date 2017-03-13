#' List database connections available in a .cnf file
#'
#' @param path the path to the .cnf file (incluidng the .cnf file name)
#' @return
#' A list of database connections listed in the .cnf file
#'
#' @examples
#' \dontrun{
#' databases <- list_from_cnf('~/.mysql.cnf')
#' }
#'
#' @export

list_from_cnf <- function(
  path = "/projects/topmed/variant_annotation/.variant-server.cnf"){ #nolint

  if (!file.exists(path)) {
    stop(".cnf file doesn't exist")
  }

  cnf <- readLines(path)
  bracketed_lines <- grep("\\[", cnf, value = TRUE)

  # remove [client] from the braketed readLines
  toclean <- bracketed_lines[-grep("client", bracketed_lines)]

  # function to remove brackets
  remove_brackets <- function(bracketed_lines_string) {
    no_leading <- sub(".*\\[", "", bracketed_lines_string)
    return(substr(no_leading, 1, nchar(no_leading) - 1))
  }

  return(lapply(toclean, remove_brackets))
}
