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

  generated_file_content <- scrub_testpkg(readLines("R/paths-apis.R"))
  expect_identical(generated_file_content, expected_file_content)
})
