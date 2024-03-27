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

.read_config <- function(config_file = "_beekeeper.yml") {
  config <- yaml::read_yaml(config_file)
  config <- .stabilize_config(config)
  return(config)
}

.stabilize_config <- function(config) {
  config$api_title <- stabilize_string(config$api_title)
  config$api_abbr <- stabilize_string(config$api_abbr)
  config$api_version <- stabilize_string(config$api_version)
  config$rapid_file <- stabilize_string(config$rapid_file)
  config$updated_on <- parse_date_time(
    config$updated_on,
    orders = c("ymd HMS", "ymd H", "ymd")
  )
  return(config)
}

.read_api_definition <- function(config_file, rapid_file) {
  readRDS(
    path(path_dir(config_file), rapid_file)
  )
}

.prepare_r <- function() {
  use_directory("R")
  use_testthat()
  quietly(use_httptest2)()
  use_package("nectar")
  use_package("beekeeper", type = "Suggests")
}
