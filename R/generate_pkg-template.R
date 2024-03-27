#' Use a template in this package
#'
#' @param template The name of the template.
#' @param dir The directory where the file should be created.
#' @param data A list of variables to apply to the template.
#'
#' @return The path to the generated or updated file, invisibly.
#' @keywords internal
.bk_use_template <- function(template,
                             dir = c("R", "tests/testthat"),
                             data) {
  dir <- match.arg(dir)
  target <- proj_path(dir, template)
  save_as <- path_rel(target, proj_path())

  use_template(
    template = template,
    save_as = save_as,
    data = data,
    package = "beekeeper"
  )
  capture.output({
    style_file(target)
  })

  return(invisible(target))
}
