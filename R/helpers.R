# package helper utility functions ------------------------------------

#' @noRd
#'
#' @export
last <- function() {
  message("You're a rock star!")
}

#' Get path to load wgsadbworkr example
#'
#' \code{wgsadbworkrr} comes bundled with sample files in its
#' \code{inst/extdata} diretory. This function makes them easier to access.
#' Based on /code{readr::readr_example()}
#'
#' @param file_name Name of file
#'
#' @examples
#' wgsadbworkr_example(file_name = "fr_5_config.tsv")
#'
#' @export
wgsadbworkr_example <- function(file_name) {
  system.file("extdata", file_name, package = "wgsadbworkr", mustWork = TRUE)
}
