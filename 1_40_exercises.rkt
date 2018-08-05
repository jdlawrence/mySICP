#lang sicp
(define tolerance 0.000001)

(define (fixed-point f guess)
  (define (good-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (sub f guess)
    (if (good-enough? guess (f guess))
        (f guess)
        (sub f (f guess))))
  (sub f guess))

;(fixed-point cos 1.0)

(define (square x) (* x x))

;(fixed-point square 1.1)

(define (average v1 v2)
  (/ (+ v1 v2) 2))

; Tolerance
(define dx 0.00001)

; Derivative
(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (define (square x) (* x x))
  (define (cube x) (* x x x))
  (lambda (x) (+ 
               (cube x)
               (* a (square x))
               (* b x)
               c)))


; Zeroes of -6, 2, 5
; (x+6)(x-2)(x-5) = x^3 - x^2 - 32x + 60
(newtons-method (cubic -1 -32 60) 4)


