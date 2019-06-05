(in-package :cl-user)
(defpackage pix-box.image
  (:use :cl)
  (:export #:resource-image-path+
	   #:+supported-image-extensions+

	   #:image-list
	   #:image-pathname
	   #:image-info
	   )
  (:nicknames :pimg)
  )
(in-package :pix-box.image)

(defvar +resource-image-path+ (merge-pathnames #P"resource/image/" (asdf:system-source-directory :pix-box)))
;; (print *default-pathname-defaults*)

(defvar +supported-image-extensions+ '("png" "jpg" "jpeg" "svg"))


(defun pathname-filename (pathspec)
  "pathnameからファイル名を返す。"
  (concatenate 'string (pathname-name pathspec) "." (pathname-type pathspec)))

(defun image-pathname (key &optional (folder +resource-image-path+))
  "画像keyと拡張子から、フルパス(pathname)を作る。"
  (probe-file (merge-pathnames folder key)))

(defun image-list (&key (image-directory +resource-image-path+) (image-extensions +supported-image-extensions+))
  "画像のファイル名リストを返す。"
  (mapcar #'pathname-filename
	  (remove-if-not #'(lambda (f) 
			     (member (string-downcase (pathname-type f)) image-extensions :test #'string=)
			     )
			 (uiop:directory-files image-directory))))


(defun image-key-p (key)
  "存在する画像keyか確認する"
      (image-pathname key))

(defun image-info (key)
  "画像keyの情報を返す。"
  (anaphora:awhen  (image-key-p key)
    (let* ((kl (image-list))
	   (i (position key kl :test #'string=)))
      `(("key" ,key)
	("next" ,(nth (1+ i) kl))
	("prev" ,(when (> i 0) (nth (1- i) kl)))
	))))
  








