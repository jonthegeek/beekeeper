test_that("config writes a yml", {
  local_mocked_bindings(
    use_build_ignore = function(...) {
      invisible(TRUE)
    }
  )
  rapid_path <- test_path("_fixtures/guru_rapid.rds")
  guru_rapid <- readRDS(rapid_path)
  config_path <- withr::local_tempfile(fileext = ".yml")
  rapid_write_path <- withr::local_tempfile(fileext = ".rds")
  test_result <- use_beekeeper(
    guru_rapid,
    api_abbr = "guru",
    config_file = config_path,
    rapid_file = rapid_write_path
  )
  expect_identical(test_result, config_path)
  reread_rapid <- readRDS(rapid_write_path)
  expect_identical(guru_rapid, reread_rapid)
  test_result_file <- scrub_config(readLines(config_path))
  expected_result_file <- scrub_config(
    readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  )
  expect_identical(
    test_result_file,
    expected_result_file
  )
})
