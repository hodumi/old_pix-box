#|
  This file is a part of pix-box project.
|#

(in-package :cl-user)
(defpackage pix-box-test-asd
  (:use :cl :asdf))
(in-package :pix-box-test-asd)

(defsystem pix-box-test
  :author ""
  :license ""
  :depends-on (:pix-box
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "pix-box"))))
  :description "Test system for pix-box"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
