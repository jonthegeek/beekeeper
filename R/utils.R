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
