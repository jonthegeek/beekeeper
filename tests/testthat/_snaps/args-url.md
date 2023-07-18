# .check_url_scalar rejects non-character

    Code
      .check_url_scalar(NULL)
    Condition
      Error:
      ! `NULL` should be a(n) single url.

---

    Code
      url_wrapper_fn(NULL)
    Condition
      Error in `url_wrapper_fn()`:
      ! `fancy_url` should be a(n) single url.

---

    Code
      .check_url_scalar(1L)
    Condition
      Error:
      ! `1L` should be a(n) single url.

---

    Code
      url_wrapper_fn(1L)
    Condition
      Error in `url_wrapper_fn()`:
      ! `fancy_url` should be a(n) single url.

---

    Code
      .check_url_scalar(1)
    Condition
      Error:
      ! `1` should be a(n) single url.

---

    Code
      url_wrapper_fn(1)
    Condition
      Error in `url_wrapper_fn()`:
      ! `fancy_url` should be a(n) single url.

---

    Code
      .check_url_scalar(mtcars)
    Condition
      Error:
      ! `mtcars` should be a(n) single url.

---

    Code
      url_wrapper_fn(mtcars)
    Condition
      Error in `url_wrapper_fn()`:
      ! `fancy_url` should be a(n) single url.

# .check_url_scalar rejects non-scalar characters

    Code
      .check_url_scalar(letters)
    Condition
      Error:
      ! `letters` should be a(n) single url.

---

    Code
      url_wrapper_fn(letters)
    Condition
      Error in `url_wrapper_fn()`:
      ! `fancy_url` should be a(n) single url.

---

    Code
      .check_url_scalar(urls)
    Condition
      Error:
      ! `urls` should be a(n) single url.

---

    Code
      url_wrapper_fn(urls)
    Condition
      Error in `url_wrapper_fn()`:
      ! `fancy_url` should be a(n) single url.

# .check_url_scalar rejects non-URLs

    Code
      .check_url_scalar("non url")
    Condition
      Error:
      ! `"non url"` should be a(n) single url.

---

    Code
      url_wrapper_fn("non url")
    Condition
      Error in `url_wrapper_fn()`:
      ! `"non url"` should be a(n) single url.

