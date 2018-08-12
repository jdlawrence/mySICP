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

(define (good-enough-2 guess x)
  (< (abs (- x (square guess) )) (* 0.00000001 x)))
      
(define (sqrt-iter guess x)
  (if (good-enough-2 guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x)
  (sqrt-iter 1.00 x))

;(sqrt 0.000004)
(sqrt 1000000000000000000)

;(improve (improve (improve 1 1000000) 100000) 1000000)
; As the radicand gets smaller, the square root produced gets much less accurate.
; This is because the initial guess, 1, is very far from the radicand, and
; Newton's method will have to go through many iterations to bring come up with an
; accurate guess. For example, if the radicand (x), is 1,000,000, the guess is 1, and
; we call sqrt-iter with a guess of 1 and x = 1,000,000. This is obviously not good enough,
; and after the first iteration of 'improve', our new guess is 1,000,001/2, which is 500,000.5.
; After the second call to guess, we're at about 250,000. The third, ~125,000. This will take
; ~(log 1,000,000)/ log2) = 20 iterations.

; When we call this function with really small numbers, we have many iterations of 'improve',
; but we also run into rounding errors that happen when we try to average very small numbers.

; Check out 'good-enough-2' for a solution that stop based on a percentage of x instead of an
; absolute difference. It doesn't work as well for large numbers because as the number gets
; really large, the absolute difference is a smaller difference and demands more precision.
