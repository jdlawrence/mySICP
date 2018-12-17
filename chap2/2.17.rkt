#lang racket

(define (last-pair aList)
  (define (sub subList val)
    (if (null? subList)
        (list val)
        (sub (cdr subList) (car subList))))
  (sub aList (car aList)))

(define jamil (list 1 2 3 4))

(last-pair jamil)

(last-pair (list 23 72 149 34))

