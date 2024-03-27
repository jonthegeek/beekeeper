`%|0|%` <- function(x, y) {
  if (!length(x)) {
    y
  } else {
    x
  }
}

.collapse_comma <- function(x) {
  glue_collapse(x, sep = ", ")
}

.collapse_comma_newline <- function(x) {
  glue_collapse(x, sep = ",\n")
}

.to_snake <- function(x) {
  to_snake_case(x, parsing_option = 3)
}
