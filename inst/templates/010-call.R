#' Call the {{api_title}} API
#'
#' Generate a request to an {{api_title}} endpoint.
#'
#' @inheritParams nectar::call_api
#'
#' @return The response from the endpoint.
#' @export
{{api_abbr}}_call_api <- function(path,
                                  method = NULL) {
  nectar::call_api(
    base_url = "{{base_url}}",
    path = path,
    method = method,
    user_agent = "{{pkg_agent}}"
  )
}
