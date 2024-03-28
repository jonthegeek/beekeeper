#' @include as_bk_data.R
NULL

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

.generate_paths_files <- function(paths_by_tag, api_abbr, security_data) {
  paths_file_paths <- imap_chr(
    paths_by_tag,
    function(path_tag, path_tag_name) {
      .generate_paths_file(path_tag, path_tag_name, api_abbr, security_data)
    }
  )
  paths_test_paths <- imap_chr(
    paths_by_tag,
    function(path_tag, path_tag_name) {
      .generate_paths_test_file(path_tag, path_tag_name, api_abbr)
    }
  )
  return(c(unname(paths_file_paths), unname(paths_test_paths)))
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
      security_data = security_data
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

S7::method(as_bk_data, class_paths) <- function(x) {
  if (!length(x)) {
    return(list())
  }
  paths_tags_df <- .paths_to_tags_df(as_tibble(x))
  return(.paths_to_tag_list(paths_tags_df))
}

.paths_to_tags_df <- function(x) {
  nest(
    filter(
      unnest(x, "operations"),
      !.data$deprecated
    ),
    .by = "tags", .key = "endpoints"
  )
}

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
      operation_id = endpoints$operation_id,
      path = endpoints$endpoint,
      summary = endpoints$summary,
      description = endpoints$description,
      params = endpoints$parameters
    ),
    .paths_endpoint_to_list
  )
}

.paths_endpoint_to_list <- function(operation_id,
                                    path,
                                    summary,
                                    description,
                                    params) {
  params_df <- .flatten_df(params)
  params <- .paths_params_to_list(params_df)
  endpoint_list <- list(
    operation_id = .to_snake(operation_id),
    path = .path_as_arg(path, params_df),
    summary = str_squish(summary),
    description = str_squish(description),
    params = params
  )
  endpoint_list$args <- .collapse_comma(params_df$name)
  endpoint_list$test_args <- endpoint_list$args
  return(endpoint_list)
}

.paths_params_to_list <- function(params) {
  if (!nrow(params)) {
    return(list())
  }
  # TODO: Deal with all the available data.
  params <- pmap(
    list(
      name = params$name,
      description = .paths_fill_descriptions(params$description)
    ),
    .paths_param_to_list
  )
  return(params)
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
  params_in <- params_df$name[params_df$`in` == "path"]
  params <- .collapse_comma(glue("{params_in} = {params_in}"))
  return(glue('c("{path}", {params})'))
}
