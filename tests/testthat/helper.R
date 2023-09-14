# Inspired by https://github.com/r-lib/usethis tests/testthat/helper.R

create_local_package <- function(pkgname = "testpkg",
                                 env = parent.frame()) {
  dir <- fs::file_temp(pattern = pkgname)

  old_wd <- getwd()

  withr::defer(
    {
      fs::dir_delete(dir)
    },
    envir = env
  )
  usethis::create_package(
    dir,
    # This is for the sake of interactive development of snapshot tests.
    # When the active usethis project is a package created with this
    # function, testthat learns its edition from *that* package, not from
    # usethis. So, by default, opt in to testthat 3e in these ephemeral test
    # packages.
    # I also need a url to check for it in user agent.
    fields = list(
      "URL" = "https://example.com",
      "Config/testthat/edition" = "3"
    ),
    rstudio = TRUE,
    open = FALSE,
    check_name = FALSE
  )

  old_project <- usethis::proj_set(dir)
  withr::defer(
    {
      usethis::proj_set(old_project, force = TRUE)
    },
    envir = env
  )

  withr::defer(
    {
      setwd(old_wd)
    },
    envir = env
  )
  setwd(usethis::proj_get())

  invisible(usethis::proj_get())
}

scrub_testpkg <- function(text) {
  gsub("testpkg[a-zA-Z0-9]+", "TESTPKG", text, perl = TRUE)
}

scrub_updated <- function(input) {
  sub(
    "updated_on:.*$",
    "updated_on: DATETIME\"",
    input
  )
}

scrub_rapid_file_location <- function(input) {
  sub(
    "rapid_file: file.*$",
    "rapid_file: RAPID_FILE_PATH\"",
    input
  )
}

scrub_config <- function(input) {
  stringr::str_trim(scrub_updated(scrub_rapid_file_location(input)))
}

scrub_tempdir <- function(input) {
  sub("^.*Rtmp\\S+", "TMPDIR", input)
}
