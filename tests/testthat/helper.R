# Inspired by https://github.com/r-lib/usethis tests/testthat/helper.R

create_local_package <- function(pkgname = "testpkg",
                                 env = parent.frame()) {
  withr::local_options(usethis.quiet = TRUE, .local_envir = env)

  dir <- withr::local_tempdir(pattern = pkgname, .local_envir = env)
  dir <- unclass(fs::path_norm(dir))

  usethis::create_package(
    dir,
    # I need a url to check for it in user agent.
    fields = list(
      "URL" = "https://example.com",
      "Config/testthat/edition" = "3"
    ),
    rstudio = TRUE,
    open = FALSE,
    check_name = FALSE
  )

  usethis::local_project(dir, quiet = TRUE, .local_envir = env)

  invisible(dir)
}

scrub_testpkg <- function(text) {
  gsub("testpkg[a-zA-Z0-9]+", "TESTPKG", text, perl = TRUE)
}

scrub_updated <- function(input) {
  sub(
    "updated_on:.*$",
    "updated_on: DATETIME",
    input
  )
}

scrub_rapid_file_location <- function(input) {
  sub(
    "rapid_file: .*$",
    "rapid_file: RAPID_FILE_PATH",
    input
  )
}

scrub_config <- function(input) {
  stringr::str_trim(scrub_updated(scrub_rapid_file_location(input)))
}

scrub_tempdir <- function(input) {
  sub("^.*Rtmp\\S+", "TMPDIR", input)
}
