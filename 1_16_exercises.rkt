#lang sicp
(define (square x) (* x x))
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))


;(fast-expt 2 2)

(define (fast-expt2 b n)
  (fast-expt-i 1 b n))

(define (fast-expt-i total b a)
  (cond ((= a 0) 1)
        ((= a 1) b)
        ((= a 2) (* total (square b)))
        ((even? a) (fast-expt-i total (square b) (/ a 2)))
        (else (fast-expt-i (* total b) b (- a 1)))))
        
(fast-expt2 3 5)