url_wrapper_fn <- function(fancy_url) {
  .check_url_scalar(fancy_url)
  return(fancy_url)
}
urls <- c(
  "http://www.posit.com",
  "http://posit.com",
  "https://www.posit.co",
  "https://posit.com"
)

test_that(".check_url_scalar rejects non-character", {
  expect_snapshot({.check_url_scalar(NULL)}, error = TRUE)
  expect_snapshot({url_wrapper_fn(NULL)}, error = TRUE)
  expect_snapshot({.check_url_scalar(1L)}, error = TRUE)
  expect_snapshot({url_wrapper_fn(1L)}, error = TRUE)
  expect_snapshot({.check_url_scalar(1.0)}, error = TRUE)
  expect_snapshot({url_wrapper_fn(1.0)}, error = TRUE)
  expect_snapshot({.check_url_scalar(mtcars)}, error = TRUE)
  expect_snapshot({url_wrapper_fn(mtcars)}, error = TRUE)
})

test_that(".check_url_scalar rejects non-scalar characters", {
  expect_snapshot({.check_url_scalar(letters)}, error = TRUE)
  expect_snapshot({url_wrapper_fn(letters)}, error = TRUE)
  expect_snapshot({.check_url_scalar(urls)}, error = TRUE)
  expect_snapshot({url_wrapper_fn(urls)}, error = TRUE)
})

test_that(".check_url_scalar rejects non-URLs", {
  expect_snapshot({.check_url_scalar("non url")}, error = TRUE)
  expect_snapshot({url_wrapper_fn("non url")}, error = TRUE)
})

test_that(".check_url_scalar returns valid input.", {
  expect_identical(.check_url_scalar(urls[[1]]), urls[[1]])
  expect_identical(url_wrapper_fn(urls[[1]]), urls[[1]])
  expect_identical(.check_url_scalar(urls[[2]]), urls[[2]])
  expect_identical(url_wrapper_fn(urls[[2]]), urls[[2]])
})
