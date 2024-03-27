test_that("%|0|% works", {
  expect_identical(
    character() %|0|% "foo",
    "foo"
  )
  expect_identical(
    "foo" %|0|% "bar",
    "foo"
  )
})
