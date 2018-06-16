#lang sicp
(define (square n) (* n n))

(define (fast-exp a n)
  (cond ((= n 0) 1)
        ((even? n) (fast-exp (square a) (/ n 2)))
        (else (* a (fast-exp a (- n 1))))))

;(fast-exp 3 3)

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(expmod 3 5 5)