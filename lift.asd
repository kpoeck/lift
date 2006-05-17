;;;-*- Mode: Lisp; Package: ASDF-LIFT -*-

#| simple-header

$Id: lift.asd,v 1.3 2005/08/09 01:56:18 gwking Exp $
$Author: gwking $
$Date: 2005/08/09 01:56:18 $

Copyright (c) 2001-2003 Gary Warren King (gwking@cs.umass.edu) 

Permission is hereby granted, free of charge, to any person obtaining a 
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, 
and/or sell copies of the Software, and to permit persons to whom the 
Software is furnished to do so, subject to the following conditions: 

The above copyright notice and this permission notice shall be included in 
all copies or substantial portions of the Software. 

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL 
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
DEALINGS IN THE SOFTWARE. 

|#

(defpackage :asdf-lift (:use #:asdf #:cl))
(in-package :asdf-lift)

;; try hard
(unless (find-system 'asdf-system-connections nil)
 (when (find-package 'asdf-install)
   (funcall (intern (symbol-name :install) :asdf-install) 'asdf-system-connections)))
;; give up with a useful (?) error message
(unless (find-system 'asdf-system-connections nil)
  (error "The LIFT system requires ASDF-SYSTEM-CONNECTIONS. See 
http://www.cliki.net/asdf-system-connections for details and download
instructions."))

;; now make sure it's loaded
(operate 'load-op 'asdf-system-connections)

(defsystem lift
  :version "1.0"
  :author "Gary Warren King <gwking@metabang.com>"
  :version "1.0"
  :maintainer "Gary Warren King <gwking@metabang.com>"
  :licence "MIT Style License"
  :description "LIsp Framework for Testing"
  :long-description "LIFT is yet another SUnit variant."
  
  :components ((:module "dev" 
                        :components ((:static-file "notes.text")
                                     
                                     (:file "lift")
                                      
                        #+Ignore
                                     (:file "prototypes"
                                            :depends-on ("lift"))))
               
               (:module "website"
                        :components ((:module "source"
                                              :components ((:static-file "index.lml"))))))
  
  :depends-on (asdf-system-connections moptilities))

;;; ---------------------------------------------------------------------------

(asdf:defsystem-connection lift-and-metatilities
  :requires (lift metatilities-base)
  :perform (load-op :after (op c)
                    (use-package (find-package :lift) 
                                 (find-package :metatilities))
                    (funcall (intern 
                              (symbol-name :export-exported-symbols)
                              'metatilities)
                             :lift :metatilities))) 





#| Gary King 2005-11-17: unnecessary (?) complexity
(defsystem BASIC-LIFT
  :version "1.0"
  :components ((:file "lift"))
  :depends-on (MOPTILITIES))

(defsystem LIFT-WITH-PROTOTYPES
  :version "1.0"
  :depends-on (BASIC-LIFT)
  :components ((:file "prototypes")))

(defsystem LIFT
  :version "1.0"
  :author "Gary Warren King <gwking@metabang.com>"
  :version "1.0"
  :maintainer "Gary Warren King <gwking@metabang.com>"
  :licence "MIT Style License"
  :description "LIsp Framework for Testing"
  :long-description "LIFT is yet another SUnit variant."
  :depends-on (BASIC-LIFT 
               #+Ignore 
               LIFT-WITH-PROTOTYPES))
|#

