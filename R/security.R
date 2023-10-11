.check_api_key <- function(security_schemes) {
  api_key_scheme_idx <- purrr::map_lgl(
    security_schemes@details,
    function(x) {
      inherits(x, "rapid::api_key_security_scheme")
    }
  )
  if (any(api_key_scheme_idx)) {
    return(
      .extract_api_key_details(security_schemes, api_key_scheme_idx)
    )
  }
  return(list())
}

.extract_api_key_details <- function(security_schemes, api_key_scheme_idx) {
  purrr::pmap(
    list(
      security_schemes@name[api_key_scheme_idx],
      security_schemes@details[api_key_scheme_idx],
      security_schemes@description[api_key_scheme_idx]
    ),
    function(security_scheme_name, details, description) {
      if (is.na(description)) {
        description <- "An API key provided by the API provider. This key is not clearly documented in the API description. Check the API documentation for details."
      }
      list(
        name = snakecase::to_snake_case(security_scheme_name),
        arg_name = stringr::str_remove(
          snakecase::to_snake_case(details@parameter_name),
          "^x_"
        ),
        location = details@location,
        parameter_name = details@parameter_name,
        description = description
      )
    }
  )
}

.generate_security <- function(api_abbr, security_schemes) {
  security_data <- list()
  api_key_data <- .check_api_key(security_schemes)
  if (length(api_key_data)) {
    security_data$api_schemes <- api_key_data
    security_data$has_security <- TRUE
    security_arg_names <- sort(
      unique(purrr::map_chr(api_key_data, "arg_name"))
    )
    security_data$security_arg_names <- security_arg_names
    .bk_use_template(
      template = "020-security.R",
      data = c(
        security_data,
        api_abbr = api_abbr
      )
    )
    security_data$security_args <- glue::glue_collapse(
      glue::glue(
        "{security_arg_names} = {security_arg_names}"
      ),
      sep = ",\n"
    )

    # For help.
    security_arg_description <- rlang::set_names(
      purrr::map_chr(api_key_data, "description"),
      purrr::map_chr(api_key_data, "arg_name")
    )
    security_arg_description <- unname(
      security_arg_description[security_arg_names]
    )
    security_data$security_arg_helps <- purrr::map2(
      security_arg_description,
      security_arg_names,
      function(arg_description, arg_name) {
        list(
          name = arg_name,
          description = arg_description
        )
      }
    )

    env_vars <- toupper(glue::glue(
      "{api_abbr}_{security_arg_names}"
    ))
    security_data$security_signature <- glue::glue_collapse(
      c(
        "",
        glue::glue(
          "{security_arg_names} = Sys.getenv(\"{env_vars}\")"
        )
      ),
      sep = ",\n"
    )
  }
  return(security_data)
}
