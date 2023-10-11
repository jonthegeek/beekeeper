#' Call the Trello API
#'
#' Generate a request to an Trello endpoint.
#'
#' @inheritParams nectar::call_api
#' @param key An API key provided by the API provider. This key is not clearly documented in the API description. Check the API documentation for details.
#' @param token An API key provided by the API provider. This key is not clearly documented in the API description. Check the API documentation for details.
#'
#' @return The response from the endpoint.
#' @export
trello_call_api <- function(path,
                            query = NULL,
                            body = NULL,
                            method = NULL,
                            key = Sys.getenv("TRELLO_KEY"),
                            token = Sys.getenv("TRELLO_TOKEN")) {
  nectar::call_api(
    base_url = "https://trello.com/1",
    path = path,
    query = query,
    body = body,
    method = method,
    user_agent = "TESTPKG (https://example.com)",
    security_fn = trello_security,
    security_args = list(
      key = key,
      token = token
    )
  )
}
