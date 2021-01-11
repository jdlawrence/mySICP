#lang sicp

#| Old definition of unless
(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))
|#

#| New definition. This would be useful if we wanted to define "unless" as a
procedure for our metacircular evalutor.

Answer:|#

(define (unless condition usual-value exceptional-value)
  (cond (condition exceptional-value)
        (else usual-value)))


#| Testing. NOTE that the unless procedure still puts us in an infinite loop in this version
because we're using Scheme built in evaluator (which is Applicative-Order) and not normal
order.
|#

(define a 1)
(define b 2)

;#|
(unless (= b 0)
  (/ a b)
  (begin (display "exception: returning 0") 0))
;|#

(define (factorial n)
(unless (= n 1)
(* n (factorial (- n 1)))
1))

;(factorial 5)

#| This causes an out of memory exception. It is because the arguments, in this case (factorial (- n 1))
are evaluated before the condition of "unless" are evaluated. So we never reach the stopping point. In
a normal order language, we'd reach the stopping point.

|#