#lang pie

;;; Frame 02
'atom

;;; Frame 03
'ratatouille

;;; Frame 05
;; "Atoms are built from a tick mark followed by one or more letters and hyphens."

;;; Frame 06
'--- ; hyphens acceptable in atom names
;; --- Not an atom, possibly a valid variable name
;; ' Not an atom, can't have a nameless quote

;;; Frame 07
'Atom

;;; Frame 08
;; 'At0m has a number in it, so is an invalid atom-name

;;; Frame 09
'cœurs-d-artichauts

;;; Frame 10
'ἄτομον ;; Unicode letters are fine?

;;; Frame 19
(the (Pair Atom Atom)
     (cons 'ratatouille 'baguette))

;;; Frame 55
;; Hmm you can construct types using regular functions.

;; (Pair (car (cons Atom 'olive))
;;       (cdr (cons 'oil Atom)))) is the same type as (Pair Atom Atom)

;;; Frame 63
1

;;; Frame 79
(claim one Nat)
(define one (add1 zero))
one

;;; Frame 81
(claim four Nat)
(define four
  (add1
   (add1
    (add1
     (add1 zero)))))
four
