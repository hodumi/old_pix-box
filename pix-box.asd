#|
  This file is a part of pix-box project.
|#

(in-package :cl-user)
(defpackage pix-box-asd
  (:use :cl :asdf))
(in-package :pix-box-asd)

(defsystem pix-box
  :version "0.1"
  :author ""
  :license ""
  :depends-on (:clack
	       :ningle
               :cl-base64
	       :anaphora
	       :jsown
	       )
  :components ((:module "src"
                :components
                ((:file "pix-box" :depends-on ("image" "web"))
		 (:file "web" :depends-on ("image"))
		 (:file "image")
		 
		 )))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op pix-box-test))))
