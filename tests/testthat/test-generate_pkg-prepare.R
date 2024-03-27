test_that(".assert_is_pkg() errors informatively for non-packages", {
  expect_snapshot(
    .assert_is_pkg(tempdir()),
    error = TRUE,
    transform = scrub_tempdir
  )
})

test_that("generate_pkg() adds nectar to import.", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  dependencies <- desc::desc()$get_deps()
  expect_identical(
    dependencies$package[dependencies$type == "Imports"],
    "nectar"
  )
})

test_that("generate_pkg() adds beekeeper to suggests.", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  dependencies <- desc::desc()$get_deps()
  expect_contains(
    dependencies$package[dependencies$type == "Suggests"],
    "beekeeper"
  )
})

test_that("generate_pkg() adds httptest2 to suggests.", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  dependencies <- desc::desc()$get_deps()
  expect_contains(
    dependencies$package[dependencies$type == "Suggests"],
    "httptest2"
  )
})

test_that("generate_pkg() adds testthat to suggests.", {
  skip_on_cran()
  config <- readLines(test_path("_fixtures", "guru_beekeeper.yml"))
  guru_rapid <- readRDS(test_path("_fixtures", "guru_rapid.rds"))

  create_local_package()
  writeLines(config, "_beekeeper.yml")
  saveRDS(guru_rapid, "guru_rapid.rds")

  generate_pkg(pkg_agent = "TESTPKG (https://example.com)")

  dependencies <- desc::desc()$get_deps()
  expect_contains(
    dependencies$package[dependencies$type == "Suggests"],
    "testthat"
  )
})
