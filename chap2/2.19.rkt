#lang racket
(define us-coins (list 50 25 10 5 1))

(define (first-denomination aList)
  (car aList))

(define (except-first-denomination aList)
  (cdr aList))

#| Testing |#
(first-denomination us-coins)
(except-first-denomination us-coins)