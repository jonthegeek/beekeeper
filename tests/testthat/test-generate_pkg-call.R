test_that("generate_pkg() generates call function.", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))
  call_expected <- readLines(test_path("_fixtures", "guru-010-call.R"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  call_result <- scrub_testpkg(readLines("R/010-call.R"))
  expect_identical(call_result, call_expected)
})

test_that("generate_pkg() generates call function test.", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))
  t_call_expected <- readLines(test_path("_fixtures", "guru-test-010-call.R"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  t_call_result <- readLines("tests/testthat/test-010-call.R")
  expect_identical(t_call_result, t_call_expected)
})
