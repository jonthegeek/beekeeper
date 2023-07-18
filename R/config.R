#' Configure a Package via an OpenAPI Spec
#'
#' @param oas An openAPI spec, or the URL of such a spec.
#' @param api_abbr A short (2-5 letter) abbreviation for the API, for use in
#'   function names and environment variables.
#' @param config_file The path to the configuration file.
#'
#' @return The OAS spec, invisibly.
#' @export
oas_config <- function(oas, api_abbr, config_file = "_beekeeper.yml") {
  # Read an oas spec and use it to set up (or, eventually, update)
  # _beekeeper.yml for the active package.
  #
  # TODO: Confirm that we're in a package.
  #
  # TODO: Accept more things for oas (url, parsed spec, probably some
  # alternative parsed spec formats).
  UseMethod("oas_config")
}

#' @export
oas_config.character <- function(oas, ...) {
  oas <- .fetch_oas(oas)
  return(oas_config(oas, ...))
}

#' @export
#' @importFrom usethis use_build_ignore
oas_config.oas <- function(oas, api_abbr, config_file = "_beekeeper.yml", ...) {
  # This probably isn't the real class yet but this idea.
  api_abbr <- .check_api_abbr(api_abbr)

  # use_build_ignore imported rather than namespaced for mocking in tests.
  use_build_ignore(config_file)
  yaml::write_yaml(
    list(
      api_title = oas$info$title,
      api_abbr = api_abbr,
      api_version = oas$info$version,
      servers = oas$servers,
      security_schemes = oas$components$securitySchemes,
      updated_on = as.character(lubridate::now(tzone = "UTC"))
    ),
    file = config_file
  )
  return(invisible(oas))
}
