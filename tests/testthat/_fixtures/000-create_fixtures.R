apid_url <- "https://api.apis.guru/v2/specs/apis.guru/2.2.0/openapi.yaml"
api_abbr <- "guru"
rapid_write_path <- test_path(glue::glue("_fixtures/{api_abbr}_rapid.rds"))
config_path <- test_path(glue::glue("_fixtures/{api_abbr}_beekeeper.yml"))
apid_url |>
  url() |>
  use_beekeeper(
    api_abbr = api_abbr,
    config_file = config_path,
    rapid_file = rapid_write_path
  )

apid_url <- "https://api.apis.guru/v2/specs/fec.gov/1.0/openapi.yaml"
api_abbr <- "fec"
rapid_write_path <- test_path(glue::glue("_fixtures/{api_abbr}_rapid.rds"))
config_path <- test_path(glue::glue("_fixtures/{api_abbr}_beekeeper.yml"))
apid_url |>
  url() |>
  use_beekeeper(
    api_abbr = api_abbr,
    config_file = config_path,
    rapid_file = rapid_write_path
  )

apid_url <- "https://api.apis.guru/v2/specs/trello.com/1.0/openapi.yaml"
api_abbr <- "trello"
rapid_write_path <- test_path(glue::glue("_fixtures/{api_abbr}_rapid.rds"))
config_path <- test_path(glue::glue("_fixtures/{api_abbr}_beekeeper.yml"))
apid_url |>
  url() |>
  use_beekeeper(
    api_abbr = api_abbr,
    config_file = config_path,
    rapid_file = rapid_write_path
  )

warning("Revert .Rbuildignore")
