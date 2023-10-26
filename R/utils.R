#' Check whether we're in a package
#'
#' Inspired by usethis:::is_package.
#'
#' @param base_path The root URL of the current project.
#'
#' @return `TRUE` if the project is a package, `FALSE` if not.
#' @keywords internal
.is_pkg <- function(base_path = usethis::proj_get()) {
  root_file <- rlang::try_fetch(
    rprojroot::find_package_root_file(path = base_path),
    error = function(cnd) NULL
  )
  !is.null(root_file)
}

#' Error if not in package
#'
#' @inheritParams .is_pkg
#'
#' @return `NULL`, invisibly.
#' @keywords internal
.assert_is_pkg <- function(base_path = usethis::proj_get()) {
  if (.is_pkg(base_path)) {
    return(invisible(NULL))
  }
  cli::cli_abort(c(
    "Can't generate package files outside of a package.",
    x = "{.path {base_path}} is not inside a package."
  ))
}

`%|0|%` <- function(x, y) {
  if (!length(x)) {
    y
  } else {
    x
  }
}

.collapse_comma <- function(x) {
  glue::glue_collapse(x, sep = ", ")
}

.collapse_comma_newline <- function(x) {
  glue::glue_collapse(x, sep = ",\n")
}
