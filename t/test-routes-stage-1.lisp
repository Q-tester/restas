
(restas:define-module restas-test-main-module
  (:use :cl))

(in-package :restas-test-main-module)

(restas:define-route main ("")
  "<h1>Hello world!</h1>")

(restas:define-route test-route-with-renderer ("renderer-test")
  (:render-method (alexandria:named-lambda
		      test-renderer (str)
		    (format nil "<h1>~a</h1>"
			    str)))
  "Hello world!")
