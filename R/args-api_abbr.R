#' Check whether an object is an API abbreviation
#'
#' @param api_abbr An abbreviation to use for this API, such as `"goog"` or
#'   `"asn"`.
#' @inherit .check_list return
#' @keywords internal
.check_api_abbr <- function(api_abbr) {
  api_abbr <- .check_character_scalar(
    api_abbr,
    expected = "single character giving a short abbreviation of the api name"
  )
  api_char <- nchar(api_abbr)
  if (api_char > 5) {
    cli::cli_warn(
      c(
        "{.arg api_abbr} should be a short abbreviation.",
        "i" = "{api_char} characters is a little high."
      )
    )
  }
  return(api_abbr)
}
