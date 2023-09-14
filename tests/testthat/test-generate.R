withr::local_options(usethis.quiet = TRUE)
test_that("Applying a 1-server config generates the expected R files.", {
  skip_on_cran()
  # Need to grab the fixtures *before* switching to the local package.
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  call_expected <- readLines(test_path("_fixtures", "guru-010-call.R"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "_beekeeper_rapid.rds")
  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")
  call_result <- readLines("R/010-call.R")
  call_result <- scrub_testpkg(call_result)
  expect_identical(call_result, call_expected)
  expect_identical(
    desc::desc()$get_deps()$package,
    "nectar"
  )
})
