#' Call the APIs.guru API
#'
#' Generate a request to an APIs.guru endpoint.
#'
#' @inheritParams nectar::call_api
#'
#' @return The response from the endpoint.
#' @export
guru_call_api <- function(path,
                          query = NULL,
                          body = NULL,
                          method = NULL) {
  nectar::call_api(
    base_url = "https://api.apis.guru/v2",
    path = path,
    query = query,
    body = body,
    method = method,
    user_agent = "TESTPKG (https://example.com)"
  )
}
