(in-package :cl-user)
(defpackage pix-box.image
  (:use :cl)
  (:export #:resource-image-path+
	   #:+browser-supported-image-extensions+

	   #:image-list
	   #:image-pathname
	   )
  (:nicknames :pimg)
  )
(in-package :pix-box.image)

(defvar +resource-image-path+ (merge-pathnames #P"resource/image/" (asdf:system-source-directory :pix-box)))
;; (print *default-pathname-defaults*)

(defvar +browser-supported-image-extensions+ '("png" "jpg" "jpeg" "svg"))


(defun pathname-filename (pathspec)
  "pathnameからファイル名を返す。"
  (concatenate 'string (pathname-name pathspec) "." (pathname-type pathspec)))

(defun image-list (&key (image-directory +resource-image-path+) (image-extensions +browser-supported-image-extensions+))
  "画像のファイル名リストを返す。"
  (mapcar #'pathname-filename
	  (remove-if-not #'(lambda (f) 
			     (member (string-downcase (pathname-type f)) image-extensions :test #'string=)
			     )
			 (uiop:directory-files image-directory))))

(defun image-pathname (name &key (image-directory +resource-image-path+))
  "ファイル名nameのフルパスを返す。ファイルが無い場合、nilを返す。"
  (probe-file (merge-pathnames name image-directory)))
