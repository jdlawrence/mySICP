#lang racket
#| Answers |#

#| Adjoin-set: Assumes the set is ordered
Time complexity is now O(1)
|#
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
      


#| Testing |# 
(define l1 (list 2 3 2 1 3 2 2))
(define l2 (list 5 6 7 8))
(define l3 (list 1))

(adjoin-set 11 l3)
