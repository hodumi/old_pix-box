#|
This file is a part of pix-box project.
|#

(in-package :cl-user)
(defpackage pix-box-server-asd
  (:use :cl :asdf))
(in-package :pix-box-server-asd)

;;; ====== asd ======

(defsystem pix-box-server
  :version "0.1"
  :author ""
  :license ""
  :depends-on ()
  :description "pix-box server commands"
  :long-description ""
  )

;;; ====== packages ======

(defpackage pix-box-server
  (:use :cl)
  (:export :+swank-port+
	   :+http-port+
	   )
  )

(in-package pix-box-server)


;;; ====== environment ======
(defun getenv (name &optional default)
  #+CMU
  (let ((x (assoc name ext:*environment-list*
		  :test #'string=)))
    (if x (cdr x) default))
  #-CMU
  (or
   #+Allegro (sys:getenv name)
   #+CLISP (ext:getenv name)
   #+ECL (si:getenv name)
   #+SBCL (sb-unix::posix-getenv name)
   #+LISPWORKS (lispworks:environment-variable name)
   default))


(defvar +swank-port+ (getenv "SWANK_PORT" 4005))
(defvar +http-port+ (getenv "HTTP_PORT" 5000))

