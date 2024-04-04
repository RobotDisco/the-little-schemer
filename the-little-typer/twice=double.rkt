#lang pie

(claim +
       (-> Nat Nat
           Nat))

(define +
  (lambda (n j)
    (iter-Nat n
               j
               (lambda (+-1)
                 (add1 +-1)))))

(claim mot-add1+=+add1
       (-> Nat Nat
           U))

(define mot-add1+=+add1
  (lambda (j k)
    (= Nat
       (add1 (+ k j))
       (+ k (add1 j)))))

(claim step-add1+=+add1
       (Pi ((j Nat)
            (n-1 Nat))
           (-> (mot-add1+=+add1 j n-1)
               (mot-add1+=+add1 j (add1 n-1)))))

(define step-add1+=+add1
  (lambda (j n-1)
    (lambda (add1+=+add1-n-1)
      (cong add1+=+add1-n-1
            (+ 1)))))

(claim add1+=+add1
       (Pi ((n Nat)
            (j Nat))
           (= Nat
              (add1 (+ n j))
              (+ n (add1 j)))))

(define add1+=+add1
  (lambda (n j)
    (ind-Nat n
             (mot-add1+=+add1 j)
             (same (add1 j))
             (step-add1+=+add1 j))))

(claim double
       (-> Nat
           Nat))

(define double
  (lambda (n)
    (iter-Nat n
              0
              (+ 2))))

(claim twice
       (-> Nat
           Nat))

(define twice
  (lambda (n)
    (+ n n)))

(claim twice=double
       (Pi ((n Nat))
           (= Nat
              (twice n)
              (double n))))

(claim mot-twice=double
       (-> Nat
           U))

(define mot-twice=double
  (lambda (k)
    (= Nat (twice k) (double k))))

(claim step-twice=double
       (Pi ((n Nat))
           (-> (mot-twice=double n)
               (mot-twice=double (add1 n)))))

;; (define step-twice=double
;;   (lambda (n-1)
;;     (lambda (step-twice=double-n-1)
;;       (cong step-twice=double-n-1
;;             (+ 2)))))
;; ————— run bob.rkt —————
;; Expected
;;   (= Nat
;;     (add1 (iter-Nat n-1
;;              (the Nat
;;                (_add1_ n-1))
;;              (λ (+-1)
;;                (add1 +-1))))
;;     (add1 (add1 (iter-Nat n-1
;;                    (the Nat 0)
;;                    (λ (j)
;;                      (add1 (add1 j)))))))
;; but given
;;   (= Nat
;;     (add1 (_add1_ (iter-Nat n-1
;;                    (the Nat n-1)
;;                    (λ (+-1)
;;                      (add1 +-1)))))
;;     (add1 (add1 (iter-Nat n-1
;;                    (the Nat 0)
;;                    (λ (j)
;;                      (add1 (add1 j)))))))

;;  bob.rkt:90:6
;;
;; OK we can see that the (cong twice=double-n-1 _(+ 2)_) leads to a result that
;; looks like
;;   (= Nat
;;     (add1 (_add1_ (iter-Nat n-1
;;                    (the Nat n-1)
;;                    (λ (+-1)
;;                      (add1 +-1)))))
;;     (add1 (add1 (iter-Nat n-1
;;                    (the Nat 0)
;;                    (λ (j)
;;                      (add1 (add1 j)))))))
;;
;; because of that (+2) applied to =from= and =to=.
;; but if you look at the claim, we need a =(mot-twice=double (add1 n))=
;; which looks like
;;   (= Nat
;;     (iter-Nat (add1 n-1)
;;       (the Nat (add1 n-1)
;;       (λ (+-1)
;;         (add1 +-1)))))
;;     (iter-Nat (add1 n-1)
;;       (the Nat 0)
;;       (λ (j)
;;         (add1 (add1 j)))))))
;;
;; we can see for the =to= that the claim matches the actual result, because
;; (double (add1 n-1)) emits a series of (add1 (add1 (...))), and structurally,
;; (double (add1 n-1)) is the same as (add1 (add1 (double n-1))). So that's fine
;;
;; Unrolling the expected =from= however, (+ (add1 n-1) (add1 n-1)), is going to
;; look like (iter-Nat (add1 n-1) (add1 n-1) (lambda (n-2) (add1 n-2))). We
;; can trivially pull out add1 from the target because we know that's going to
;; be a leading add1,
;; so (iter-Nat (add1 n-1) (the Nat (add1 n-1)) (lambda (n-2) (add1 n-2)))
;; easily becomes
;; so (add1 (iter-Nat n-1 (the Nat (add1 n-1)) (lambda (n-2) (add1 n-2))))
;; but we can't expand more than that.
;;
;; However, we have a previous proof, add1+=+add1, that shows us that
;; (add1 (+ n-1 (add1 n-1))) is the same as (add1 (add1 (+ n-1 n-1)))
;;
;; so do we have a tool to help us leverage this known equality?
;; yes. (replace target mot base)

(claim mot-step-twice=double
       (-> Nat Nat
           U))

(define mot-step-twice=double
  (lambda (n-1 k)
    (= Nat
       (add1 k)
       (add1 (add1 (double n-1))))))


(define step-twice=double
  (lambda (n-1)
    (lambda (twice=double-n-1)
      (replace
       ;; Our target, the (= Nat (add1 (+ n-1 n-1)) (+ n-1 (add n-1))) we are leveraging
       (add1+=+add1 n-1 n-1)
       ;; The motive producing the types for our from and to.
       ;; from: (= Nat (add1 (add1 (+ n-1 n-1))) (add1 (add1 (double n-1))))
       ;; to: (= Nat (add1 ((+ n-1 (add n-1)))) (add1 (add1 (double n-1))))
       (mot-step-twice=double n-1)
       ;; The base is a value of type (mod from)
       ;; here it is (= Nat (add1 (add1 (+ n-1 n-1))) (add1 (add1 (double
       ;; n-1))))
       ;; as we saw from the "given" error above.
       ;; we can expand this to
       ;; (= Nat
       ;;   (add1 (add1 (iter-Nat n-1
       ;;                 (the Nat n-1)
       ;;                   (lambda (n-2)
       ;;                     (add1 n-2)))))
       ;;   (add1 (add1 (iter-Nat n-1
       ;;                 (the Nat 0)
       ;;                   (lambda (n-2)
       ;;                     (add1 (add1 n-2)))))))
       (cong twice=double-n-1
             (+ 2))))))

;; The result of this has the following type:
;; to: (= Nat (add1 (+ n-1 (add1 n-1))) (add1 (add1 (double n-1))))
;; which we can expand to
;; (= Nat
;;   (add1 (iter-Nat n-1
;;           (the Nat (add1 n-1))
;;           (lambda (n-2)
;;             (add1 n-2)))))
;;   (add1 (add1 (iter-Nat n-1
;;                 (the Nat 0)
;;                   (lambda (n-2)
;;                     (add1 (add1 n-2)))))))
;;
;; which is what the above expectation was in our error.
;; so our result now matches the expectation, and this means
;; we will compile.

(define twice=double
  (lambda (n)
    (ind-Nat n
             mot-twice=double
             (same 0)
             step-twice=double)))



