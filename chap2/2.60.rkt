#lang racket
#| Answer |#
#| element-of-set doesn't change at all |#
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))


#| Adjoin-set also doens't change at all |#
(define (adjoin-set x set)
  (if (element-of-set? x set)
      set
      (cons x set)))

(define l1 (list 2 3 2 1 3 2 2))

(element-of-set? 3 l1)
(element-of-set? 13 l1)