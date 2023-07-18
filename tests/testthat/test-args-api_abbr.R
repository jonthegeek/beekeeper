abbr_wrapper_fn <- function(fancy_abbr) {
  .check_api_abbr(fancy_abbr)
  return(fancy_abbr)
}

test_that(".check_api_abbr rejects non-character", {
  expect_snapshot({.check_api_abbr(NULL)}, error = TRUE)
  expect_snapshot({abbr_wrapper_fn(NULL)}, error = TRUE)
  expect_snapshot({.check_api_abbr(1L)}, error = TRUE)
  expect_snapshot({abbr_wrapper_fn(1L)}, error = TRUE)
  expect_snapshot({.check_api_abbr(1.0)}, error = TRUE)
  expect_snapshot({abbr_wrapper_fn(1.0)}, error = TRUE)
  expect_snapshot({.check_api_abbr(mtcars)}, error = TRUE)
  expect_snapshot({abbr_wrapper_fn(mtcars)}, error = TRUE)
})

test_that(".check_api_abbr rejects non-scalar characters", {
  expect_snapshot({.check_api_abbr(letters)}, error = TRUE)
  expect_snapshot({abbr_wrapper_fn(letters)}, error = TRUE)
})

test_that(".check_api_abbr warns about long abbrevs", {
  expect_snapshot({.check_api_abbr("this is long")})
  expect_snapshot({abbr_wrapper_fn("this is long")})
})

test_that(".check_api_abbr returns valid input", {
  expect_identical(.check_api_abbr("this"), "this")
  expect_identical(abbr_wrapper_fn("this"), "this")
  expect_identical(.check_api_abbr("that"), "that")
  expect_identical(abbr_wrapper_fn("that"), "that")
})
