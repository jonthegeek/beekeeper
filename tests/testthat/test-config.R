test_that("config writes a yml", {
  local_mocked_bindings(
    use_build_ignore = function(...) {
      invisible(TRUE)
    },
    read_yaml = function(file, handlers) {
      readRDS(testthat::test_path("_fixtures/guru_read_yaml.rds"))
    }
  )
  config_path <- withr::local_tempfile(fileext = ".yml")
  test_result <- oas_config(
    oas = "https://api.apis.guru/v2/openapi.yaml",
    api_abbr = "guru",
    config_file = config_path
  )
  expect_s3_class(test_result, "oas")
  test_result_file <- readLines(config_path)
  expect_snapshot(
    test_result_file,
    transform = function(input) {
      sub(
        "updated_on:.*\"$",
        "updated_on: DATETIME\"",
        input
      )
    }
  )
})
