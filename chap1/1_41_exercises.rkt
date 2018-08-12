#lang sicp
(define (double proc)
  (lambda (x) (proc (proc x))))

(define (inc x)
  (+ x 1))

;(inc 3)
;((double inc) 3)

;(((double double) inc) 5)

#|
The inner (double double) increments by 4.
Therefore double of this calls this inc-by-4 four times,
increasing the value by 16. This makes the final result
21.
|#
(((double (double (double double))) inc) 5)