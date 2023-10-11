httptest2::with_mock_dir("api/01-call/valid", {
  test_that("Can call an endpoint without errors", {
    # A path will be auto-filled in a future version of beekeeper.
    fail(
      "Provide any path for this API in PROVIDED_PATH, then delete this fail."
    )
    PROVIDED_PATH <- "path/to/endpoint"
    expect_no_error({{api_abbr}}_call_api(PROVIDED_PATH))
  })
})
