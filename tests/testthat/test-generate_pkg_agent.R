test_that("generate_pkg_agent() generates package agents", {
  expect_identical(
    generate_pkg_agent(test_path("_fixtures", "DESCRIPTION")),
    "beekeeper (https://beekeeper.api2r.org)"
  )
})
