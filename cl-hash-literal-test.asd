#|
  This file is a part of cl-hash-literal project.
  Copyright (c) 2019 dn (dice.k.nakatani@gmail.com)
|#

(defsystem "cl-hash-literal-test"
  :defsystem-depends-on ("prove-asdf")
  :author "dn"
  :license "MIT"
  :depends-on ("cl-hash-literal"
               "prove")
  :components ((:module "tests"
                :components
                ((:test-file "cl-hash-literal"))))
  :description "Test system for cl-hash-literal"

  :perform (test-op (op c) (symbol-call :prove-asdf :run-test-system c)))
