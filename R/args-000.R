#' Generate checker error messages
#'
#' @param expected The expected argument class or type.
#' @param arg The name of the argument.
#' @param call The environment from which the checker was called.
#'
#' @keywords internal
.check_error <- function(expected,
                         arg = rlang::caller_arg(url),
                         call = rlang::caller_env()) {
  cli::cli_abort(
    "{.arg {arg}} should be a(n) {expected}.",
    arg = arg,
    call = call
  )
}

#' Check whether an object is a list
#'
#' @param x The object to check.
#' @inheritParams .check_error
#'
#' @return The input, if it is valid.
#' @keywords internal
.check_list <- function(x,
                        expected = "list",
                        arg = rlang::caller_arg(url),
                        call = rlang::caller_env()) {
  if (rlang::is_list(x)) {
    return(x)
  }
  .check_error(expected, arg, call)
}

#' Check whether an object has length 1
#'
#' @inheritParams .check_list
#' @inherit .check_list return
#' @keywords internal
.check_scalar <- function(x,
                          expected,
                          arg = rlang::caller_arg(url),
                          call = rlang::caller_env()) {
  if (length(x) == 1) {
    return(x)
  }
  .check_error(expected, arg, call)
}

#' Check whether an object is a character vector
#'
#' @inheritParams .check_list
#' @inherit .check_list return
#' @keywords internal
.check_character <- function(x,
                             expected = "character",
                             arg = rlang::caller_arg(url),
                             call = rlang::caller_env()) {
  if (is.character(x)) {
    return(x)
  }
  .check_error(expected, arg, call)
}

#' Check whether an object is a length-1 character vector
#'
#' @inheritParams .check_list
#' @inherit .check_list return
#' @keywords internal
.check_character_scalar <- function(x,
                                    expected = "single character",
                                    arg = rlang::caller_arg(url),
                                    call = rlang::caller_env()) {
  x <- .check_character(x, expected, arg, call)
  x <- .check_scalar(x, expected, arg, call)
  return(x)
}
