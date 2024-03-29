test_that("generate_pkg() returns a vector of created files", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))

  test_dir <- create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  test_result <- generate_pkg(pkg_agent = "TESTPKG (https://example.com)")
  test_result <- scrub_path(test_result)
  expected_result <- c(
    "/R/010-call.R",
    "/tests/testthat/test-010-call.R",
    "/R/paths-apis.R",
    "/tests/testthat/test-paths-apis.R",
    "/tests/testthat/setup.R"
  )

  expect_identical(test_result, expected_result)
})
