(in-package :cl-user)
(defpackage pix-box.web
  (:use :cl)
    (:import-from :jsown
		#:new-js
		#:to-json
		)
    (:import-from :pix-box.image
		  #:image-list
		  #:image-pathname)
    (:export #:start-server
	     #:stop-server
	     )
    )
(in-package :pix-box.web)

;;; JSON ==============================================
(eval-when (:compile-toplevel :execute)
  (defmacro to-response-json (&rest responses)
    `(jsown:to-json (jsown:new-js ,@responses)))

  )

(defmethod JSOWN:TO-JSON ((p pathname))
  (JSOWN:TO-JSON (namestring p)))


;;; IMAGE =============================================
(defun image-content-type (file)
  (let ((ext (pathname-type file)))
    (cond
      ((string= ext "png") "image/png")
      ((or (string= ext "jpeg") (string= ext "jpg")) "image/jpeg")
      ((string= ext "svg") "image/svg+xml")
      )))


;;; SERVER ===============================================
(defvar *app* (make-instance 'ningle:app))
(defvar *server* nil)

;; API ---------------------------------------------------
(setf (ningle:route *app* "/api/images.json" :method :get)
      #'(lambda (params)
	  (declare (ignore params))
	  (let ((images (pix-box.image:image-list)))
	    (list 200 `(:content-type "application/json")
		  (list (to-response-json   
			 ("images" images)
			 ))))))

(setf (ningle:route *app* "/api/images/:file" :method :get)
      #'(lambda (params)
	  (let ((file (cdr (assoc :file params))))
	    (ANAPHORA:aif (pimg:image-pathname file) 
			  `(200 (:content-type ,(image-content-type file)) ,anaphora:it)
			  `(404 (:content-type "text/plain") ("not found"))))))

;; VIEW ------------------------------------------------

; TODO: favicon.ico

(setf (ningle:route *app* "/")
      `(200 (:content-type "text/html") ,(pimg:image-pathname "../html/index.html") ))

(setf (ningle:route *app* "/reset.min.css")
      `(200 (:content-type "text/css; charset=UTF-8") ,(pimg:image-pathname "../css/rest.min.css") ))

(setf (ningle:route *app* "/*.*")
      #'(lambda (params)
	  (anaphora:aif (pimg:image-pathname (concatenate 'string
							  "../html/"
							  (first (cdr (assoc :splat params)))
							  "."
							  (second (cdr (assoc :splat params)))
							  ))
			`(200 (:content-type "text/html") ,anaphora:it)
			`(404 (:content-type "text/plain") ("not found")))))      
(defun start-server ()
  (setq *server* (clack:clackup *app*)))

(defun stop-server ()
  (setq *server* (clack:stop *server*)))

