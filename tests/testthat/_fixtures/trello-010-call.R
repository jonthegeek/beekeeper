# Set up the basic call once at package build.
trello_req_base <- nectar::req_setup(
  "https://trello.com/1",
  user_agent = "TESTPKG (https://example.com)"
)

#' Call the Trello API
#'
#' Generate a request to an Trello endpoint.
#'
#' @inheritParams nectar::req_modify
#' @param key An API key provided by the API provider. This key is not clearly documented in the API description. Check the API documentation for details.
#' @param token An API key provided by the API provider. This key is not clearly documented in the API description. Check the API documentation for details.
#'
#' @return The response from the endpoint.
#' @export
trello_call_api <- function(path,
                            query = NULL,
                            body = NULL,
                            method = NULL, key = Sys.getenv("TRELLO_KEY"),
                            token = Sys.getenv("TRELLO_TOKEN")) {
  req <- nectar::req_modify(
    trello_req_base,
    path = path,
    query = query,
    body = body,
    method = method
  )
  req <- .trello_req_auth(req, key = key, token = token)
  resp <- nectar::req_perform_opinionated(req)
  nectar::resp_parse(resp, response_parser = .trello_response_parser)
}
