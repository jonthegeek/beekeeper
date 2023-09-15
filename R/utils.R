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

.stabilize_chr_scalar_nonempty <- function(x,
                                           x_arg = rlang::caller_arg(x),
                                           call = rlang::caller_env()) {
  stbl::stabilize_chr_scalar(
    x,
    allow_null = FALSE,
    allow_zero_length = FALSE,
    allow_na = FALSE,
    x_arg = x_arg,
    call = call
  )
}
