#lang pie

;; Frame 52
(claim gauss
       (-> Nat
           Nat))

;; Frame 59
;;
;; Doesn't work because + isn't defined and because we cannot do named recursion
;;
;; (define gauss
;;   (lambda (n)
;;     (which-Nat n
;;               0
;;               (lambda (n-1)
;;                 (+ (add1 n-1) (gauss n-1))))))

;; Frame 80
;;
;; Wrong, (Pair Nat Nat) describes the type of data, not the type of a type.
;; (claim Pear
;;        (Pair Nat Nat))
(claim Pear
       U)

;; Wrong, cons is a data constructor, can't be used to make a type, only data values.
;; (define Pear
;;   (cons Nat Nat))
(define Pear
  (Pair Nat Nat))
