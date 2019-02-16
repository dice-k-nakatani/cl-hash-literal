(defpackage cl-hash-literal-test
  (:use :cl
        :cl-hash-literal
        :prove))
(in-package :cl-hash-literal-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-hash-literal)' in your Lisp.

(plan nil)

(cl-syntax:use-syntax :cl-hash-literal)

(subtest "read-table"
  (is (let ((tab #1h(:a 10 :b 20))) (gethash :b tab)) 20)
  )

(subtest "print-object"
  (is (with-hash-literal-printer
        (prin1-to-string #1h(:a 10 :b 20)))
      "#1h(:A 10 :B 20 )")

  (is (with-hash-literal-printer
        (prin1-to-string 
         (let ((tab (make-hash-table :test #'eql)))
           (setf (gethash :a tab) 10
                 (gethash :b tab) 20)
           tab)))
      "#1h(:A 10 :B 20 )")
  )

(finalize)
