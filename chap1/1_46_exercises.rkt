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
  (lambda (guess)
    (define (sub guess)
      (if (good-enough guess)
          guess
          (sub (improve guess))))
    (sub guess)))

#|
Version that uses an alternative form of a lambda (anonymous) function

(define (iterative-improve good-enough improve)
  (define (sub guess)
    (if (good-enough guess)
      guess
        (sub (improve guess))))
    sub)
|#

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

(define (fixed-point f val1)
  ((iterative-improve
    (lambda (guess)
      (< (abs (- guess (f guess))) .0001))
    (lambda (guess)
      (f guess)))
   val1))
    
(fixed-point cos 1.0)