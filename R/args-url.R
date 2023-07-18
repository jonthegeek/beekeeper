#' Check whether an object is a URL
#'
#' @inheritParams .check_character_scalar
#' @param url A url, such as `"https://www.example.com"`.
#' @inherit .check_list return
#' @keywords internal
.check_url_scalar <- function(url,
                              arg = rlang::caller_arg(url),
                              call = rlang::caller_env()) {
  url <- .check_character_scalar(url, "single url", arg, call)
  if (grepl("^http", url)) {
    return(url)
  }
  .check_error("single url", arg, call)
}
