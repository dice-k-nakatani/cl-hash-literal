#|
  This file is a part of cl-hash-literal project.
  Copyright (c) 2019 dn (dice.k.nakatani@gmail.com)
|#

#|
  Author: dn (dice.k.nakatani@gmail.com)
|#

(defsystem "cl-hash-literal"
  :version "0.1.0"
  :author "dn"
  :license "MIT"
  :depends-on (:cl-syntax)
  :components ((:module "src"
                :components
                ((:file "cl-hash-literal"))))
  :description ""
  :long-description
  #.(read-file-string
     (subpathname *load-pathname* "README.markdown"))
  :in-order-to ((test-op (test-op "cl-hash-literal-test"))))
