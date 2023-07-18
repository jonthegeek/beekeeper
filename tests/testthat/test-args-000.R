list_wrapper_fn <- function(fancy_x) {
  .check_list(fancy_x, "fancy list")
  return(fancy_x)
}

test_that(".check_list rejects non-lists", {
  expect_snapshot({.check_list(NULL)}, error = TRUE)
  expect_snapshot({list_wrapper_fn(NULL)}, error = TRUE)
  expect_snapshot({.check_list(1L)}, error = TRUE)
  expect_snapshot({list_wrapper_fn(1L)}, error = TRUE)
  expect_snapshot({.check_list(1.0)}, error = TRUE)
  expect_snapshot({list_wrapper_fn(1.0)}, error = TRUE)
  expect_snapshot({.check_list(letters)}, error = TRUE)
  expect_snapshot({list_wrapper_fn(letters)}, error = TRUE)
})

test_that(".check_list returns valid input.", {
  actual_list <- list(a = 1, b = letters)
  expect_identical(.check_list(actual_list), actual_list)
  expect_identical(list_wrapper_fn(actual_list), actual_list)
  expect_identical(.check_list(mtcars), mtcars)
  expect_identical(list_wrapper_fn(mtcars), mtcars)
})
