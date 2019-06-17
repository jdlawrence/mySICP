#lang racket
#| Answers |#

#| Union-set: Assumes the set is ordered
Time complexity is now O(n)
|#
(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        ((= (car s1) (car s2)) (cons (car s1) (union-set (cdr s1) (cdr s2))))
        ((< (car s1) (car s2)) (cons (car s1) (union-set (cdr s1) s2)))
        ((< (car s2) (car s1)) (cons (car s2) (union-set s1 (cdr s2))))
        (else (union-set (cdr s1) s2))))

#| Testing |# 
(define l1 (list 1 2 3))
(define l2 (list 3 4 5 6))
(define l3 (list 1 3 5 7))
(define l4 (list 2 4 6 8))

(union-set l3 l4)
