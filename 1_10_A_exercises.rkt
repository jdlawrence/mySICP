#lang sicp
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1) (A x (- y 1) )))))

#|
(A 3 3)
(A 2 (A 3 2))
(A 2 (A 2 (A 3 1))
(A 2 (A 2 2))
(A 2 (A 1 (A 2 1)))
(A 2 (A 1 2))
(A 2 (A 0 (A 1 1)))
(A 2 (A 0 2))
(A 2 4)
We know from the previous exercise that this is 65536

(A 2 4)
(A 1 (A 2 3))
(A 1 (A 1 (A 2 2)))
(A 1 (A 1 (A 1 (A 2 1))))
(A 1 (A 1 (A 1 2)))
(A 1 (A 1 (A 0 (A 1 1))))
(A 1 (A 1 (A 0 2)))
(A 1 (A 1 4))
(A 1 16)
(A 0 (A 1 15))
(A 0 32768)
65536
|#

#|
(define (f n) (A 0 n)) computes 2n
(define (g n) (A 1 n)) computes 2^n
(define (h n) (A 2 n)) computes 2^2^...n times 
|#
(A 2 5)
