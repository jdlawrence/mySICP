#lang sicp
(define (average x y)
  (/ (+ x y) 2))


;(average 2 3)

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(define (square x) (* x x))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x)
  (sqrt-iter 1.00 x))

;(sqrt 4)

;(new-if) causes an infinite because it is a procedure, and procedures
; are evaluated with applicative-order evaluation. This means that all procedures
; must be broken down (evaluated) until we get to PRIMITIVE OPERATORS (+, -, *, /, 1, 2, 3, etc)
; Since sqrt-iter is recursive, it will never get down to primitive operators
; Check out https://gist.github.com/jolisper/3688628

