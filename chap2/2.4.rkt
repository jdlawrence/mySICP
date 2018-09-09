#lang sicp

(define (jcons x y)
 (define (dispatch m)
 (cond ((= m 0) x)
 ((= m 1) y)
 (else (error "Argument not 0 or 1 -- CONS" m))))
 dispatch)

(define (jcar z) (z 0))
(define (jcdr z) (z 1))

(jcar (jcons 2 3))

#| Setup for the exercise |#
(define (lcons x y)
 (lambda (m) (m x y)))

(define (lcar z)
 (z (lambda (p q) p)))

#| Actual Exercise |#
(define (lcdr z)
  (z (lambda (p q) q)))

#| Testing |#
(lcar (lcons 2 3))
(lcdr (lcons 2 3))

#| Substitution model from 1.1.5 
(lcdr (lcons 2 3))
becomes
(lcdr (lambda (m) (m 2 3)))
becomes
((lambda (m) (m 2 3)) (lambda (p q) q))
becomes
((lambda (p q) q) 2 3)
which returns 3
|#

#| Further Testing |#
((lambda (p q) q) 2 3)
