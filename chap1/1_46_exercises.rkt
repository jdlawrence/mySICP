#lang sicp
(define (square x) (* x x))
(define (cube x) (* x x x))

(define (average v1 v2)
  (/ (+ v1 v2) 2))

(define (improve-root guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
 (< (abs (- (square guess) x)) 0.001))

(define (iterative-improve good-enough improve)
  (lambda (x)
    (define (sub guess)
      (if (good-enough guess)
          guess
          (sub (improve guess))))
    (sub x)))

(define (sqrt x)
  ((iterative-improve
    (lambda (guess)
      (< (abs (- (square guess) x)) 0.001))
    (lambda (guess)
      (average guess (/ x guess))))
   1.0))
  
(sqrt 20.0)

(define (close-enough? x y)
 (< (abs (- x y)) 0.001))

(define (fixed-point f guess)
  ((iterative-improve
   (lambda (guess)
     (< (abs (- (f guess) guess)) 0.001))
   (lambda (guess)
     (f guess)))
   (f guess)))
(fixed-point cos 1.0)