#lang sicp
(define (square n) (* n n))

(define (fast-exp a n)
  (cond ((= n 0) 1)
        ((even? n) (fast-exp (square a) (/ n 2)))
        (else (* a (fast-exp a (- n 1))))))

(fast-exp 3 3)