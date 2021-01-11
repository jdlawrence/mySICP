#lang sicp
(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

(define a 1)
(define b 2)

#|
(unless (= b 0)
  (/ a b)
  (begin (display "exception: returning 0") 0))
|#

(define (factorial n)
(unless (= n 1)
(* n (factorial (- n 1)))
1))

(factorial 5)

#| This causes an out of memory exception. It is because the arguments, in this case (factorial (- n 1))
are evaluated before the condition of "unless" are evaluated. So we never reach the stopping point. In
a normal order language, we'd reach the stopping point.

|#