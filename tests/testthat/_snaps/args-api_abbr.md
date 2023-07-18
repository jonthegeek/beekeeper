# .check_api_abbr rejects non-character

    Code
      .check_api_abbr(NULL)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      abbr_wrapper_fn(NULL)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      .check_api_abbr(1L)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      abbr_wrapper_fn(1L)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      .check_api_abbr(1)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      abbr_wrapper_fn(1)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      .check_api_abbr(mtcars)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      abbr_wrapper_fn(mtcars)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

# .check_api_abbr rejects non-scalar characters

    Code
      .check_api_abbr(letters)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

---

    Code
      abbr_wrapper_fn(letters)
    Condition
      Error in `.check_api_abbr()`:
      ! `url` should be a(n) single character giving a short abbreviation of the api name.

# .check_api_abbr warns about long abbrevs

    Code
      .check_api_abbr("this is long")
    Condition
      Warning:
      `api_abbr` should be a short abbreviation.
      i 12 characters is a little high.
    Output
      [1] "this is long"

---

    Code
      abbr_wrapper_fn("this is long")
    Condition
      Warning:
      `api_abbr` should be a short abbreviation.
      i 12 characters is a little high.
    Output
      [1] "this is long"

