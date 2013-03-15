
(restas:define-module restas-test-mounted-module
  (:use :cl))

(in-package :restas-test-mounted-module)

(restas:define-route main ("")
  "<h1>Hello mounted world!</h1>")

(restas:define-route in-house-renderer-test ("renderer-test")
  (:render-method (alexandria:named-lambda test-renderer (str)
		    (format nil "<h1>~a</h1>"
			    str)))
  "Hello mounted and rendered world!")
