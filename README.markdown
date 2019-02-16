# cl-hash-literal

## Synopsis

### Use hash-table literal read table.

```text
$ ros install dice-k-nakatani/cl-hash-literal # or load with asdf or quicklisp.
$ ros run                                     # or launch repl with sbcl, ccl64 etc.
(require :cl-hash-literal)
(cl-syntax:use-syntax :cl-hash-literal)
;; change syntax-table
(let ((tab #1h(:a 10 :b 20))) (gethash :b tab))
;; => 20, t
```

### Print object with hash-table literal read.

```text
(use-package :cl-hash-literal)
;; import with-hash-literal-printer

(with-hash-literal-printer
    (prin1-to-string 
      (let ((tab (make-hash-table :test #'eql)))
        (setf (gethash :a tab) 10
              (gethash :b tab)  20)
        tab)))
;; => "#1h(:A 10 :B 20 )"
```

## Description

Sometimes we need hash-table literal.
`plist` is not enough.
`alist` is redundant to write and not enough yet.

`cl-hash-literal` provides:

1. hash-table literal syntax `#h(:a 1 :b 2)`.

2. macro to print-object with hash-table literal syntax.

The `#h` syntax is the same as the cl21's one.

But with `cl-hash-literal`, you can specify the test function
(in other words, looseness level on equality) with numarg.

`#1h(:a 1 :b 2)` is a hash-table with `eql` test function.

Here is the list of numarg.

```
0 : eq
1 : eql
2 : equal
3 : equalp
otherwise : equal
```

## Author

* dn (dice.k.nakatani@gmail.com)

## Copyright

Copyright (c) 2019 dn (dice.k.nakatani@gmail.com)

## License

Licensed under the MIT License.
