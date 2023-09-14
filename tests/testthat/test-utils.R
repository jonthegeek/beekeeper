test_that(".assert_is_pkg() errors informatively for non-packages", {
  expect_snapshot(
    .assert_is_pkg(tempdir()),
    error = TRUE,
    transform = scrub_tempdir
  )
})
