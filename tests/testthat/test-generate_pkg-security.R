test_that("generate_pkg() generates call function with API keys", {
  skip_on_cran()
  local_mocked_bindings(
    .generate_paths = function(...) {
      character()
    }
  )
  config <- readLines(test_path("_fixtures", "trello_beekeeper.yml"))
  trello_rapid <- readRDS(test_path("_fixtures", "trello_rapid.rds"))
  call_expected <- readLines(test_path("_fixtures", "trello-010-call.R"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(trello_rapid, "trello_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  call_result <- scrub_testpkg(readLines("R/010-call.R"))
  expect_identical(call_result, call_expected)
})

test_that("generate_pkg() generates security functions", {
  skip_on_cran()
  local_mocked_bindings(
    .generate_paths = function(...) {
      character()
    }
  )
  config <- readLines(test_path("_fixtures", "trello_beekeeper.yml"))
  trello_rapid <- readRDS(test_path("_fixtures", "trello_rapid.rds"))
  security_expected <- readLines(test_path("_fixtures", "trello-020-auth.R"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(trello_rapid, "trello_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  security_result <- scrub_testpkg(readLines("R/020-auth.R"))
  expect_identical(security_result, security_expected)
})
