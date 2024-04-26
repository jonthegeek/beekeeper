# Set up the basic call once at package build.
{{api_abbr}}_req_base <- nectar::req_setup(
  "{{base_url}}",
  user_agent = "{{pkg_agent}}"
)

#' Call the {{api_title}} API
#'
#' Generate a request to an {{api_title}} endpoint.
#'
#' @inheritParams nectar::req_modify{{#security_arg_helps}}
#' @param {{name}} {{{description}}}{{/security_arg_helps}}
#'
#' @return The response from the endpoint.
#' @export
{{api_abbr}}_call_api <- function(path,
                                  query = NULL,
                                  body = NULL,
                                  method = NULL{{#has_security}},{{{security_signature}}}{{/has_security}}) {
  req <- nectar::req_modify(
    {{api_abbr}}_req_base,
    path = path,
    query = query,
    body = body,
    method = method
  )
  {{#has_security}}req <- .{{api_abbr}}_req_auth(req, {{security_arg_list}}){{/has_security}}
  resp <- nectar::req_perform_opinionated(req)
  nectar::resp_parse(resp, response_parser = .{{api_abbr}}_response_parser)
}
