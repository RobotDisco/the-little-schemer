#lang pie

;;; Frame 4
;; (claim peas TODO)

;;; Frame 5
;; (claim peas
;;        (Pi ((n Nat))
;;            TODO))

;;; Frame 7
;; (claim peas
;;        (Pi ((n Nat))
;;            (Vec Atom n)))

;; (define peas TODO)

;;; Frame 8
;; (claim peas
;;        (Pi ((n Nat))
;;            (Vec Atom n)))

;; (define peas
;;   (lambda (n)
;;     TODO))

;;; Frame 11
;; (claim peas
;;        (Pi ((n Nat))
;;            (Vec Atom n)))
;; (define peas
;;   (lambda (n)
;;     (ind-Nat n
;;              (lambda (k)
;;                (Vec Atom k))
;;              TODO
;;              TODO)))

;;; Frame 13
;; (claim peas
;;        (Pi ((n Nat))
;;            (Vec Atom n)))
;; (define peas
;;   (lambda (n)
;;     (ind-Nat n
;;              (lambda (k)
;;                (Vec Atom k))
;;              vecnil
;;              (lambda (n-1 peas-of-n-1)
;;                (vec:: TODO TODO)))))

;;; Frame 13
(claim peas
       (Pi ((n Nat))
           (Vec Atom n)))
(define peas
  (lambda (n)
    (ind-Nat n
             (lambda (k)
               (Vec Atom k))
             vecnil
             (lambda (n-1 peas-of-n-1)
               (vec:: 'peas peas-of-n-1)))))

(peas 3)
