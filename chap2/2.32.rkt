#lang racket
(define nil '())

(define (j item) item)

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (items) (cons (car s) items)) rest)))))

(subsets (list 1 2))

(define (f x)
  ((lambda (a) (* a a))
   x))

#| Answer
This works by concatenating the existing powerset with each item. For example, if the subset is
(empty, 1, 2, 12), and the item is 3, the concatenation is (empty- 3 (just 3), 13, 23, 123)

Putting these together gives
(empty, 1, 2, 12, 3, 13, 23, 123)

Assuming the set is (1, 2, 3, 4), the next step would be to concat the existing set with a concatenation
 of 4 and the existing set.
|#

(define (map-square items)
  (map f items))

#| Testing |#
(map-square (list 1 2 3 45))
  