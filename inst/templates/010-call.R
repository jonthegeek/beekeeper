#' Call the {{api_title}} API
#'
#' Generate a request to an {{api_title}} endpoint.
#'
#' @inheritParams nectar::call_api{{#security_arg_helps}}
#' @param {{name}} {{{description}}}{{/security_arg_helps}}
#'
#' @return The response from the endpoint.
#' @export
{{api_abbr}}_call_api <- function(path,
                                  query = NULL,
                                  body = NULL,
                                  method = NULL{{{security_signature}}}) {
  nectar::call_api(
    base_url = "{{base_url}}",
    path = path,
    query = query,
    body = body,
    method = method,
    user_agent = "{{pkg_agent}}"{{#has_security}},
    security_fn = {{api_abbr}}_security,
    security_args = list({{security_args}}){{/has_security}}
  )
}
