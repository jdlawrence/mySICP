#lang sicp
(define (double x)
  (+ x x ))
(define (halve x)
  (/ x 2))

(define (mul a b)
  (define (sub total a b)
  (cond ((= b 0) total)
        ((even? b) (sub total (double a) (halve b)))
        (else (sub (+ total a) a (- b 1)))))
  (sub 0 a b))




(mul 3 2)