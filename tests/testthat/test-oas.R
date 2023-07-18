test_that(".fetch_oas fetches a spec", {
  local_mocked_bindings(
    read_yaml = function(file, handlers) {
      readRDS(testthat::test_path("_fixtures/guru_read_yaml.rds"))
    }
  )

  expect_snapshot(
    {
      guru <- .fetch_oas("https://api.apis.guru/v2/openapi.yaml")
      guru
    }
  )

  expect_snapshot({names(guru)})

  expect_equal(length(guru), 10)
})
