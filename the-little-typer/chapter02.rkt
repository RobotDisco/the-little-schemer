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

;; Frame 93
(claim Pear-maker U)
(define Pear-maker
  (-> Nat Nat
      Pear))

(claim elim-Pear
  (-> Pear Pear-maker
      Pear))
(define elim-Pear
  (lambda (pear maker)
    (maker (car pear) (cdr pear))))

;; wrote claim of elim-Pear without using Pear or Pear-maker
;; (claim elim-Pear
;;        (-> (Pair Nat Nat) (-> Nat Nat
;;                             (Pair Nat Nat))
;;            (Pair Nat Nat)))

;; Frame 100
(claim pearwise+
       (-> Pear Pear
           Pear))

;; Doesn't work because + isn't defined
;; this is incorrect but seems simpler?
;;
;; (define pearwise+
;;   (lambda (pa pb)
;;     (cons (+ (car pa) (car pb))
;;           (+ (cdr pa) (cdr pb)))))

;; Doesn't work because + isn't defined
;; OK so what is the point of this frame?
;;
;; (define pearwise+
;;   (lambda (pa pb)
;;     (elim-Pear pa (lambda (paa pad)
;;                     (elim-Pear pb (lambda (pba pbd)
;;                                     (cons (+ paa pba)
;;                                           (+ pad pbd))))))))
