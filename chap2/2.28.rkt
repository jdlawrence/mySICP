#lang racket
(define x (list (list 1 2) (list 3 4)))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (fringe aList)
  (define (sub items result)
    (cond ((null? items) result)
          ((not (pair? items)) (append result (list items)))
          (else (append (sub (car items) result) (sub (cdr items) result)))))
  (sub aList '()))

(define test1 (list 1 2 3 4))

(fringe test1)
(fringe x)
