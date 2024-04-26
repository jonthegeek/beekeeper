.generate_paths <- function(paths, api_abbr, security_data, base_url) {
  # TODO: Do any APIDs lack tags?
  # TODO: Do any APIDs have multiple tags?
  paths_by_tag <- as_bk_data(paths)
  paths_file_paths <- character()
  if (length(paths_by_tag)) {
    paths_file_paths <- .generate_paths_files(
      paths_by_tag,
      api_abbr,
      security_data
    )
    setup_file <- .bk_use_template(
      template = "setup.R",
      data = list(base_url = base_url),
      dir = "tests/testthat"
    )
    paths_file_paths <- c(paths_file_paths, setup_file)
  }
  return(paths_file_paths)
}

# reshape data -----------------------------------------------------------------

S7::method(as_bk_data, class_paths) <- function(x) {
  if (!length(x)) {
    return(list())
  }
  paths_tags_df <- .paths_to_tags_df(as_tibble(x))
  return(.paths_to_tag_list(paths_tags_df))
}

.paths_to_tags_df <- function(x) {
  x <- unnest(x, "operations")
  x <- x[!x$deprecated, ]
  nest(
    x,
    .by = "tags", .key = "endpoints"
  )
}

## to tag list -----------------------------------------------------------------
.paths_to_tag_list <- function(paths_tags_df) {
  set_names(
    map(
      paths_tags_df$endpoints,
      .paths_endpoints_to_lists
    ),
    .to_snake(paths_tags_df$tags)
  )
}

.paths_endpoints_to_lists <- function(endpoints) {
  pmap(
    list(
      operation_id = .paths_fill_operation_id(
        endpoints$operation_id,
        endpoints$endpoint,
        endpoints$operation
      ),
      path = endpoints$endpoint,
      summary = .paths_fill_summary(
        endpoints$summary,
        endpoints$endpoint,
        endpoints$operation
      ),
      description = .paths_fill_descriptions(endpoints$description),
      params_df = endpoints$parameters,
      method = endpoints$operation
    ),
    .paths_endpoint_to_list
  )
}

### fill data ------------------------------------------------------------------

.paths_fill_operation_id <- function(operation_id, endpoint, method) {
  .coalesce(.to_snake(operation_id), glue("{method}_{.to_snake(endpoint)}"))
}

.paths_fill_summary <- function(summary, endpoint, method) {
  endpoint_spaced <- str_replace_all(.to_snake(endpoint), "_", " ")
  .coalesce(
    str_squish(summary),
    str_to_sentence(glue("{method} {endpoint_spaced}"))
  )
}

### create whisker data --------------------------------------------------------

.paths_endpoint_to_list <- function(operation_id,
                                    path,
                                    summary,
                                    description,
                                    params_df,
                                    method) {
  params_df <- .prepare_paths_df(params_df)
  return(
    list(
      operation_id = operation_id,
      path = .path_as_arg(path, params_df),
      method = method,
      summary = summary,
      description = description,
      params = .params_to_list(params_df),
      params_query = .extract_params_type(params_df, "query"),
      params_header = .extract_params_type(params_df, "header"),
      params_cookie = .extract_params_type(params_df, "cookie")
    )
  )
}

.prepare_paths_df <- function(params_df) {
  params_df <- .flatten_df(params_df)
  if (nrow(params_df)) {
    params_df <- params_df[!params_df$deprecated, ]
    params_df$description <- .paths_fill_descriptions(params_df$description)
  }
  return(params_df)
}

.params_to_list <- function(params_df) {
  if (!nrow(params_df)) {
    return(list())
  }
  # TODO: Deal with all the available data.
  params <- pmap(
    list(
      name = params_df$name,
      description = params_df$description
    ),
    .paths_param_to_list
  )
  return(params)
}

.extract_params_type <- function(params_df, filter_in) {
  if (!nrow(params_df)) {
    return(character())
  }
  return(params_df$name[params_df$`in` == filter_in])
}

.paths_fill_descriptions <- function(descriptions) {
  descriptions[is.na(descriptions)] <- "BKTODO: No description provided."
  return(str_squish(descriptions))
}

.paths_param_to_list <- function(name, description) {
  list(
    name = name,
    description = description
  )
}

.path_as_arg <- function(path, params_df) {
  if (!nrow(params_df) || !any(params_df$`in` == "path")) {
    return(glue('"{path}"'))
  }
  params_path <- params_df$name[params_df$`in` == "path"]
  params <- .collapse_comma_self_equal(params_path)
  return(glue('c("{path}", {params})'))
}

.collapse_comma_self_equal <- function(x) {
  .collapse_comma(glue("{x} = {x}"))
}

# generate files ----------------------------------------------------------

.generate_paths_files <- function(paths_by_tag, api_abbr, security_data) {
  unlist(imap(
    paths_by_tag,
    function(path_tag, path_tag_name) {
      .generate_paths_tag_files(
        path_tag,
        path_tag_name,
        api_abbr,
        security_data
      )
    }
  ))
}

.generate_paths_tag_files <- function(path_tag,
                                      path_tag_name,
                                      api_abbr,
                                      security_data) {
  path_tag <- .prepare_path_tag(
    path_tag,
    security_data$security_arg_names
  )
  file_path <- .generate_paths_file(
    path_tag,
    path_tag_name,
    api_abbr,
    security_data
  )
  test_path <- .generate_paths_test_file(path_tag, path_tag_name, api_abbr)
  return(c(unname(file_path), unname(test_path)))
}

.prepare_path_tag <- function(path_tag, security_args) {
  path_tag <- map(
    path_tag,
    function(path) {
      path$params <- .remove_security_args(path$params, security_args)
      path$params_cookie <- .prep_param_args(path$params_cookie, security_args)
      path$params_header <- .prep_param_args(path$params_header, security_args)
      path$params_query <- .prep_param_args(path$params_query, security_args)
      path$args <- .params_to_args(path$params)
      path$test_args <- path$args
      return(path)
    }
  )
}

.params_to_args <- function(params) {
  .collapse_comma(map_chr(params, "name")) %|"|% character()
}

.remove_security_args <- function(params, security_args) {
  discard(
    params,
    function(param) {
      param$name %in% security_args
    }
  )
}

.prep_param_args <- function(params, security_args) {
  .collapse_comma_self_equal(setdiff(params, security_args)) %|"|% character()
}

.generate_paths_file <- function(path_tag,
                                 path_tag_name,
                                 api_abbr,
                                 security_data) {
  .bk_use_template(
    template = "paths.R",
    data = list(
      paths = path_tag,
      api_abbr = api_abbr,
      has_security = security_data$has_security,
      security_signature = security_data$security_signature,
      security_arg_list = security_data$security_arg_list
    ),
    target = glue("paths-{path_tag_name}.R")
  )
}

.generate_paths_test_file <- function(path_tag, path_tag_name, api_abbr) {
  .bk_use_template(
    template = "test-paths.R",
    data = list(
      paths = path_tag,
      tag = path_tag_name,
      api_abbr = api_abbr
    ),
    dir = "tests/testthat",
    target = glue("test-paths-{path_tag_name}.R")
  )
}
