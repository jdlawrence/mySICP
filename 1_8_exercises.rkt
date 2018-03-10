#lang sicp
(define (average x y)
  (/ (+ x y) 2))

(define (square x) (* x x))

(define (cube x) (* (square x) x))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough guess x)
  (< (abs (- x (cube guess) )) (* 0.001 x)))
      
(define (cbrt-iter guess x)
  (if (good-enough guess x)
      guess
      (cbrt-iter (improve guess x)
                 x)))

(define (cbrt x)
  (cbrt-iter 1.00 x))

;(improve 1 8)

(cbrt .000008)