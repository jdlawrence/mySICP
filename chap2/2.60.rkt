#lang racket
#| Answers |#

#| element-of-set doesn't change at all
Time complexity is still O(n)
|#
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))


#| Adjoin-set can be improved
Time complexity is now O(1)
|#
(define (adjoin-set x set)
  (cons x set))

#| Union-set: if you can have duplicates in a set, then union-set
just has to join the two sets together
Time complexity has improved from O(n^2) to O(n)
|#
(define (union-set s1 s2)
  (if (null? s1)
      s2
      (union-set (cdr s1) (cons (car s1) s2))))

#| Intersection-set: Doesn't change for duplicates allowed
Time complex is still O(n^2) |#
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

#| Testing |# 
(define l1 (list 2 3 2 1 3 2 2))
(define l2 (list 5 6 7 8))

(element-of-set? 3 l1)
(element-of-set? 13 l1)
(adjoin-set 11 l1)
(union-set l1 l2)
(intersection-set l1 l2)
