test_that("as_bk_data warns for unknown classes", {
  stbl::expect_pkg_warning_snapshot(
    {
      test_result <- as_bk_data("a")
    },
    "beekeeper",
    "bk_data",
    "missing_method"
  )
  expect_type(test_result, "list")
  expect_length(test_result, 0)
})
