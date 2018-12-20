#lang racket
(define us-coins (list 50 25 10 5 1))

(define (first-denomination aList)
  (car aList))

(define (except-first-denomination aList)
  (cdr aList))

(define (no-more? aList)
  (null? aList))

#| Testing |#
(first-denomination us-coins) ; 50
(except-first-denomination us-coins) ; (25 10 5 1)
(no-more? us-coins) ; false
(no-more? (list)) ; true