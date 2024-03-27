.generate_security <- function(api_abbr, security_schemes) {
  security_data <- as_bk_data(security_schemes)
  if (length(security_data)) {
    security_data$security_file_path <- .bk_use_template(
      template = "020-security.R",
      data = c(security_data, api_abbr = api_abbr)
    )
    security_data$security_signature <- .generate_security_signature(
      security_data$security_arg_names, api_abbr
    )
  }
  return(security_data)
}

.generate_security_signature <- function(security_arg_names, api_abbr) {
  env_vars <- toupper(glue("{api_abbr}_{security_arg_names}"))
  return(
    .collapse_comma_newline(c("", glue(
      "{security_arg_names} = Sys.getenv(\"{env_vars}\")"
    )))
  )
}
