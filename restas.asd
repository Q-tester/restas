;;;; restas.asd
;;;;
;;;; This file is part of the RESTAS library, released under Lisp-LGPL.
;;;; See file COPYING for details.
;;;;
;;;; Author: Moskvitin Andrey <archimag@gmail.com>

(defsystem #:restas
    :depends-on (#:hunchentoot #:bordeaux-threads #:routes #:alexandria #:data-sift)
    :pathname "src"
    :components ((:file "packages")
                 (:file "special" :depends-on ("packages"))
                 (:file "declarations" :depends-on ("packages"))
                 (:file "errors" :depends-on ("special"))
                 (:file "render" :depends-on ("special"))
                 (:file "context" :depends-on ("special"))                 
                 (:file "module" :depends-on ("context" "declarations"))
                 (:file "route" :depends-on ("module" "render"))
                 (:file "decorators" :depends-on ("route"))
                 (:file "vhost" :depends-on ("special"))
                 (:file "hunchentoot" :depends-on ("vhost" "module" "errors"))
                 (:file "policy" :depends-on ("packages"))))

     ;; #+swank-archimag
     ;; (:module "slime" 
     ;;          :components ((:file "restas-swank"))
     ;;          :depends-on ("src"))))

(defsystem #:restas-test
  :depends-on (#:restas #:fiveam #:drakma #:alexandria)
  :components
  ((:module "t"
            :components
            ((:file "suite" :depends-on ("test-routes-stage-1" "mounted-module"))
	     (:file "test-routes-stage-1" :depends-on ("mounted-module"))
	     (:file "mounted-module")))))

(defmethod perform ((o test-op) (c (eql (find-system '#:restas))))
  (operate 'load-op '#:restas-test)
  (funcall (intern "RUN-TESTING" :restas-test)))
