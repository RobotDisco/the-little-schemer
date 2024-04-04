#lang pie

;;; Frame 1
(define gauss
  (lambda (n)
    (which-Nat n
               0
               (lambda (n-1)
                 (+ 
