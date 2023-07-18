#' Fetch an OpenAPI Document
#'
#' @param oas_url A single character giving the URL of the document.
#'
#' @return An object with class `oas`, representing the API document.
#' @importFrom yaml read_yaml
#' @keywords internal
.fetch_oas <- function(oas_url) {
  # Load an APID. Use the URL and/or shape of the return to determine how to
  # parse it (either yaml or json). Assume yaml at first, though.
  oas_url <- .check_url_scalar(oas_url)

  # read_yaml is imported rather than namespaced for easier mocking in tests.
  oas <- read_yaml(
    oas_url,
    handlers = list(
      int = as.character
    )
  )
  return(.new_oas(oas))
}

# TODO: Make a formal vctrs-style oas object. This might change if we move that
# into tibblify or a separate package. The object will be the parsed spec, for
# use everywhere else in this package.

#' Create an oas object
#'
#' @param x A list created by reading an OAS spec with read_yaml.
#'
#' @return That list with additional class `oas`.
#' @keywords internal
.new_oas <- function(x = list()) {
  x <- .check_list(x)
  vctrs::new_vctr(x, class = "oas")
}
