#' Use a beekeeper config file to generate code
#'
#' Creates or updates package files based on the information in a beekeeper
#' config file (generated by [use_beekeeper()] or manually). The files enforce
#' an opinionated framework for API packages.
#'
#' @param config_file The path to a beekeeper yaml file.
#' @param pkg_agent A string to identify this package, for use in the
#'   `user_agent` argument of [nectar::req_setup()].
#'
#' @return A character vector of paths to files that were added or updated,
#'   invisibly.
#' @export
generate_pkg <- function(config_file = "_beekeeper.yml",
                         pkg_agent = generate_pkg_agent(config_file)) {
  # TODO: Confirm that they use github & everything is committed. Error or warn
  # if not, letting them know that this can be destructive. Skip this check in
  # tests.
  .assert_is_pkg()
  config <- .read_config(config_file)
  api_definition <- .read_api_definition(config_file, config$rapid_file)
  .prepare_r()
  touched_files <- .generate_pkg_impl(config, api_definition, pkg_agent)
  return(invisible(touched_files))
}

.generate_pkg_impl <- function(config, api_definition, pkg_agent) {
  security_data <- .generate_security(
    config$api_abbr,
    api_definition@components@security_schemes
  )
  call_files <- .generate_call(config, api_definition, pkg_agent, security_data)
  path_files <- .generate_paths(
    api_definition@paths,
    config$api_abbr,
    security_data,
    api_definition@servers@url
  )
  touched_files <- c(call_files, security_data$security_file_path, path_files)
  return(invisible(touched_files))
}
