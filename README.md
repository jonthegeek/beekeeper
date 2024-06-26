
<!-- README.md is generated from README.Rmd. Please edit that file -->

# beekeeper <a href="https://beekeeper.api2r.org"><img src="man/figures/logo.svg" align="right" height="120" /></a>

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/beekeeper)](https://CRAN.R-project.org/package=beekeeper)
[![Codecov test
coverage](https://codecov.io/gh/jonthegeek/beekeeper/branch/main/graph/badge.svg)](https://app.codecov.io/gh/jonthegeek/beekeeper?branch=main)
[![R-CMD-check](https://github.com/jonthegeek/beekeeper/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/jonthegeek/beekeeper/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Use beekeeper to create and maintain R packages that wrap APIs. The
generated packages follow best practices, including documentation and
testing.

This package focuses on APIs that follow the [OpenAPI Specification
(OAS)](https://spec.openapis.org/oas/v3.1.0). Currently versions 3.0 and
3.1 are supported, with support for swagger 2.0 to come. The APIs must
have an API document in yaml format. The package skeletons generated by
beekeeper implement best practices to streamline package development.

## The Plan

This project has been accepted by the [R Consortium 2023 ISC Grant
Program](https://www.r-consortium.org/all-projects/awarded-projects/2023-group-1#api2r:%20An%20R%20Package%20for%20Auto-Generating%20R%20API%20Clients)!

This is a rough outline of the planned development milestones of this
package, working toward a stable version 1.0.0. Most of the outline was
included in the grant proposal.

- [x] **pre-0.1.0: Infrastructure.**
  - I split the OpenAPI-parsing functionality into a separate package,
    [{rapid}](https://rapid.api2r.org). That package is being developed
    parallel to this one, and contains all of the *R API
    D*efinition-specific functionality.
  - I also realized I need a package for wrapping {httr2} calls. That
    package is called [{nectar}](https://nectar.api2r.org), and is also
    being developed parallel to this one.
- [x] **0.1.0: Basic authentication and endpoint calls.**
  - Export a function or functions to generate `R/*.R` files to call an
    API, given the URL of an OpenAPI spec in YAML format (or a
    `rapid::class_rapid()` object). The generated files will follow and
    encourage best practices, and will serve as the core around which
    the rest of a package would be built.
  - Also generate a `tests/testthat/*.R` file for that generated
    function.
  - Generate `R/*.R` and `tests/testthat/*.R` files to authenticate the
    user (using API keys).
  - Produce a vignette about configuring authentication. Folded into the
    main vignette since it’s suprisingly straightforward.
- [x] **0.2.0: OAS definition discovery.**
  - Add support for APIs using the OAS json format.
  - Streamline discovery of API definitions (with associated error
    handling).
    - **UPDATE:** This functionality is in a separate package,
      [{anyapi}](https://anyapi.api2r.org).
- [x] **0.3.0: Endpoint function scaffolding.**
  - Generate R/*.R and tests/testthat/*.R files for all endpoints
    (“paths”) described in the given API specification.
  - The generated functions will work, but error checking,
    documentation, and tests will be minimal.
  - **Potential challenges:** I’ll need to strike a balance here between
    getting a basic working system and producing something that can be
    easily expanded later.
    - **Update:** Also, this likely could go unsaid, but, if the API
      description is incorrect, the functions will not work as expected.
      Hopefully their error messages will be helpful for debugging,
      though!
- [x] **0.4.0: Batching and rate limiting.**
  - Add documentation for implementing batching and rate-limiting.
  - If possible, export functionality to help implement these processes,
    but standards seem to vary widely.
  - **Potential challenges:** This step will involve more reading and
    documenting than code, to gather examples of how different APIs
    implement limits and batching. It’s possible systems will be so
    different that it will be difficult to summarize them. For example,
    Slack has two separate batching systems in its API, with some
    functions moved to the newer system, and others not.
    - **UPDATE:** The [development version of
      {httr2}](https://github.com/r-lib/httr2/) has functionality to
      help with this quite a lot, thankfully! I’m skipping this
      milestone while that functionality stabilizes (this was previously
      0.3.0).
- [ ] **0.5.0: More robust scaffolding.**
  - [ ] Add parameter documentation.
  - [ ] Also add parameter type checking.
  - [ ] **Potential challenges:** By this point I’ll need an OAS
    definition document to use for testing that includes all of the
    possible parameter types. I’ll likely need to generate a fake API
    specification that goes beyond a typical individual example.
- **0.6.0: Expected results.**
  - Add response (return value) documentation.
  - Use expected responses to generate better test scaffolds.
  - **Potential challenges:** Testing the generation of tests might
    present unique challenges. I’ll need to look into how testthat tests
    itself.
- **0.7.0: Error messaging.**
  - Add more robust error messaging for non-standard responses.
  - **Potential challenges:** Mocking cases where things fail can be
    tricky. Ideally this step will involve pushing the package to a
    stable 1.0.0, but that will require enough usage to feel confident
    that the core function definitions are stable.

## Installation

<div class=".pkgdown-release">

Install the released version of beekeeper from
[CRAN](https://cran.r-project.org/):

``` r
# (not yet, so instead install the dev version)
# install.packages("pak")
pak::pak("jonthegeek/beekeeper")
```

</div>

<div class=".pkgdown-devel">

Install the development version of beekeeper from
[GitHub](https://github.com/):

``` r
# install.packages("pak")
pak::pak("jonthegeek/beekeeper")
```

</div>

## Usage

Use `use_beekeeper()` to generate a `_beekeeper.yml` file, and then
`generate_pkg()` to generate code based on that configuration.

Read `vignette("beekeeper")` for more details.

## The api2r package ’verse

- {beekeeper} (this package) is intended to help you rapidly create an R
  package that interfaces with a web API.
- [{nectar}](https://nectar.api2r.org) applies an opinionated framework
  around [{httr2}](https://httr2.r-lib.org/), aimed at making it easy to
  create standardized API-wrapping packages. Packages generated by
  {beekeeper} import functions from {nectar}, to avoid the relatively
  high dependency graph associated with {beeekeeper}.
- [{rapid}](https://rapid.api2r.org) converts OpenAPI descriptions of
  APIs to R objects. These objects are meant to provide a standardized
  starting point for {beekeeper} (and any future packages that generate
  R code from API specs, or, eventually, API specs from R code).
- [{anyapi}](https://anyapi.api2r.org) is intended to aid in the
  discovery of APIs. Eventually it may also auto-generate functions to
  interact with a newly discovered API, but that functionality is not
  yet implemented.

## Why “beekeeper”?

A beekeeper is someone who tends to bees, and {beekeeper} is a package
that helps you tend to APIs. “Apis” is Latin for “bee”, and is the
[genus name for honey bees](https://en.wikipedia.org/wiki/Honey_bee).

In addition to the pun, I hope to eventually include a “hive” of hex
logos on this site, with each hex representing an API package that has
been “tended” by {beekeeper}.

## Code of Conduct

Please note that the beekeeper project is released with a [Contributor
Code of Conduct](https://beekeeper.api2r.org/CODE_OF_CONDUCT.html). By
contributing to this project, you agree to abide by its terms.
