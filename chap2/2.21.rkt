#lang racket
(define (square-list1 items)
  (if (null? items)
      '()
      (cons (* (car items) (car items)) (square-list1 (cdr items)))))

(define (square-list2 items)
  (map (lambda (x) (* x x)) items))

(square-list1 (list 1 2 3 4 5 6))
(square-list2 (list 1 2 3 4 5 6))