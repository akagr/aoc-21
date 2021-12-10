(defsystem "advent-of-code"
  :version "0.1.0"
  :author "Akash Agrawal <akagr@outlook.com>"
  :license "MIT"
  :depends-on ()
  :components ((:module "day-1"
                        :components
                        ((:file "input")
                         (:file "solution" :depends-on ("input"))))
               (:module "day-2"
                        :components
                        ((:file "input")
                         (:file "solution" :depends-on ("input"))))
               (:module "day-3"
                        :components
                        ((:file "input")
                         (:file "solution" :depends-on ("input"))))
               (:module "day-4"
                        :components
                        ((:file "input")
                         (:file "solution" :depends-on ("input"))))
               (:module "day-5"
                        :components
                        ((:file "input")
                         (:file "solution" :depends-on ("input")))))
  :description "Hacking around for Advent of Code 2021")
