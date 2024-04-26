# Set up the basic call once at package build.
guru_req_base <- nectar::req_setup(
  "https://api.apis.guru/v2",
  user_agent = "TESTPKG (https://example.com)"
)

#' Call the APIs.guru API
#'
#' Generate a request to an APIs.guru endpoint.
#'
#' @inheritParams nectar::req_modify
#'
#' @return The response from the endpoint.
#' @export
guru_call_api <- function(path,
                          query = NULL,
                          body = NULL,
                          method = NULL) {
  req <- nectar::req_modify(
    guru_req_base,
    path = path,
    query = query,
    body = body,
    method = method
  )

  resp <- nectar::req_perform_opinionated(req)
  nectar::resp_parse(resp, response_parser = .guru_response_parser)
}
