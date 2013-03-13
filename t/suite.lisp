(defpackage :restas-test
  (:use :cl :5am))

(in-package :restas-test)

(defparameter *port* 8183)

(def-suite stage-1)

(in-suite stage-1)

(defparameter *host*
  (format nil "http://localhost:~a/"
	  *port*))

(defun start-test-platform ()
  (restas:start 'restas-test-main-module
		:port *port*))

(defun run-testing ()
  (start-test-platform)
  (5am:run! 'stage-1))

(test get-request
  (is-true
   (string= (drakma:http-request *host*)
	    "<h1>Hello world!</h1>")))

(test route-with-renderer
  (is-true
   (string= (drakma:http-request (format nil "~a~a"
					 *host*
					 "renderer-test"))
	    "<h1>Hello world!</h1>")))
