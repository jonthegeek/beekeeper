test_that(".assert_is_pkg() errors informatively for non-packages", {
  expect_snapshot(
    .assert_is_pkg(tempdir()),
    error = TRUE,
    transform = scrub_tempdir
  )
})

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
