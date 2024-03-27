#' Create a user agent for the active package
#'
#' @param path The path to the DESCRIPTION file, or to a directory within a
#'   package.
#'
#' @return A string with the name of the package and (if available) the first
#'   URL associated with the package.
#'
#' @export
generate_pkg_agent <- function(path = ".") {
  if (!is_dir(path) && path_file(path) != "DESCRIPTION") {
    path <- path_dir(path) # nocov
  }
  pkg_desc <- desc(file = path)
  pkg_name <- pkg_desc$get_field("Package")
  pkg_url <- .get_pkg_url(pkg_desc)
  return(
    glue("{pkg_name}{pkg_url}")
  )
}

.get_pkg_url <- function(pkg_desc) {
  pkg_url_glue <- ""
  pkg_url <- pkg_desc$get_urls()
  if (length(pkg_url)) {
    pkg_url_glue <- glue(
      " ({pkg_url[[1]]})"
    )
  }
  return(pkg_url_glue)
}
