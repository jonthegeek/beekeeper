#' Configure a package to use beekeeper
#'
#' Create a configuration file for a package to use beekeeper. The configuration
#' file tracks information that will be used for generation of other functions,
#' and the timestamp when the configuration was last updated or used.
#'
#' @inheritParams rlang::args_dots_empty
#' @param x An object to use to define the configuration, such as a
#'   [rapid::rapid()] or a url to an OpenAPI document.
#' @param api_abbr A short (about 2-5 letter) abbreviation for the API, for use
#'   in function names and environment variables.
#' @param config_file The path to the configuration file to write.
#' @param rapid_file The path to the rapid rds file to write.
#'
#' @return The path to the configuration file, invisibly. The config file is
#'   written as a side effect of this function. The rapid object is also
#'   written, and the path to that file is saved in the config file.
#' @export
use_beekeeper <- S7::new_generic(
  "use_beekeeper",
  "x",
  function(x,
           api_abbr,
           ...,
           config_file = "_beekeeper.yml",
           rapid_file = "_beekeeper_rapid.rds") {
    rlang::check_dots_empty()
    S7::S7_dispatch()
  }
)

#' @importFrom usethis use_build_ignore
S7::method(use_beekeeper, rapid::rapid) <-
  function(x,
           api_abbr,
           ...,
           config_file = "_beekeeper.yml",
           rapid_file = "_beekeeper_rapid.rds") {
    api_abbr <- nectar::stabilize_string(api_abbr)
    config_file <- nectar::stabilize_string(config_file)
    rapid_file <- nectar::stabilize_string(rapid_file)
    saveRDS(x, rapid_file)

    use_build_ignore(c(config_file, rapid_file))

    yaml::write_yaml(
      list(
        api_title = x@info@title,
        api_abbr = api_abbr,
        api_version = x@info@version,
        rapid_file = fs::path_rel(rapid_file, fs::path_dir(config_file)),
        updated_on = as.character(lubridate::now(tzone = "UTC"))
      ),
      file = config_file
    )
    return(invisible(config_file))
  }

S7::method(use_beekeeper, S7::class_any) <-
  function(x,
           api_abbr,
           ...,
           config_file = "_beekeeper.yml",
           rapid_file = "_beekeeper_rapid.rds") {
    x <- as_rapid(x)
    use_beekeeper(x, api_abbr, ..., config_file = config_file)
  }

.read_config <- function(config_file = "_beekeeper.yml") {
  config <- yaml::read_yaml(config_file)
  config$updated_on <- lubridate::parse_date_time(
    config$updated_on,
    orders = c("ymd HMS", "ymd H", "ymd")
  )
  return(config)
}
