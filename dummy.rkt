#lang racket

(append (list 1 2 ) (list 3 4))


#|
(cons 1 (list 2 3))

(cons (list 1 2) 3)

|#

(define (square x)
  (* x x))

(square 30)

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list (cdr items))
       )))

(define (myAppend list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (myAppend (cdr list1) list2))))

(myAppend (list 1 2) (list 3 4))

(define (reverse aList)
  (if (null? aList)
      '()
      (append (reverse (cdr aList)) (list (car aList)) )))

(reverse (list 1 2 3))

(cons 1 3)