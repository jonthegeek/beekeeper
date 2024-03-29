test_that("generate_pkg() generates path functions for guru", {
  # 1 tag, no security
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))
  expected_file_content <- readLines(
    test_path("_fixtures", "guru-paths-apis.R")
  )

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  generated_file_content <- readLines("R/paths-apis.R")
  expect_identical(generated_file_content, expected_file_content)
})

test_that("generate_pkg() generates path tests for guru", {
  # 1 tag, no security
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))
  expected_file_content <- readLines(
    test_path("_fixtures", "guru-test-paths-apis.R")
  )

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  generated_file_content <- readLines("tests/testthat/test-paths-apis.R")
  expect_identical(generated_file_content, expected_file_content)
})

test_that("generate_pkg() generates test setup file for guru", {
  # 1 tag, no security
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))
  expected_file_content <- readLines(
    test_path("_fixtures", "guru-setup.R")
  )

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  generated_file_content <- readLines("tests/testthat/setup.R")
  expect_identical(generated_file_content, expected_file_content)
})

test_that("generate_pkg() generates path functions for fec", {
  # 19 tags, more complicated security
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "fec_subset_beekeeper.yml"))
  fec_rapid <- readRDS(test_path("_fixtures", "fec_subset_rapid.rds"))
  expected_file_content <- readLines(
    test_path("_fixtures", "fec-paths-audit.R")
  )

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(fec_rapid, "fec_subset_rapid.rds")

  changed_files <- generate_pkg(pkg_agent = "TESTPKG (https://example.com)")
  expect_snapshot(scrub_path(changed_files))

  generated_file_content <- readLines("R/paths-audit.R")
  expect_identical(generated_file_content, expected_file_content)
})

test_that("generate_pkg() generates path functions for trello", {
  # some tags failed before this, more complicated security
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "trello_beekeeper.yml"))
  trello_rapid <- readRDS(test_path("_fixtures", "trello_rapid.rds"))
  expected_file_content <- readLines(
    test_path("_fixtures", "trello-paths-board.R")
  )

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(trello_rapid, "trello_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  generated_file_content <- readLines("R/paths-board.R")
  expect_identical(generated_file_content, expected_file_content)
})
