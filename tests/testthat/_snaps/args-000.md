# .check_list rejects non-lists

    Code
      .check_list(NULL)
    Condition
      Error:
      ! `url` should be a(n) list.

---

    Code
      list_wrapper_fn(NULL)
    Condition
      Error in `list_wrapper_fn()`:
      ! `url` should be a(n) fancy list.

---

    Code
      .check_list(1L)
    Condition
      Error:
      ! `url` should be a(n) list.

---

    Code
      list_wrapper_fn(1L)
    Condition
      Error in `list_wrapper_fn()`:
      ! `url` should be a(n) fancy list.

---

    Code
      .check_list(1)
    Condition
      Error:
      ! `url` should be a(n) list.

---

    Code
      list_wrapper_fn(1)
    Condition
      Error in `list_wrapper_fn()`:
      ! `url` should be a(n) fancy list.

---

    Code
      .check_list(letters)
    Condition
      Error:
      ! `url` should be a(n) list.

---

    Code
      list_wrapper_fn(letters)
    Condition
      Error in `list_wrapper_fn()`:
      ! `url` should be a(n) fancy list.

