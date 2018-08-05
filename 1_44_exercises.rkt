#lang sicp
(define (double proc)
  (lambda (x) (proc (proc x))))

(define (inc x)
  (+ x 1))

; Useful helper function
(define (square x) (* x x))
(define (compose f g)
  (lambda (x) (f (g x))))


(define (average3 x y z)
  (/ (+ x y z) 3))

(define (smooth f dx)
  (lambda (x) (average3
               (f (- x dx))
               (f x)
               (f (+ x dx)))))
(define pi 3.141592653589)

((smooth sin 0.7) (/ pi 2))
((smooth sin 0.27) (/ pi 2))

; Helper from 1.43
(define (repeated f n)
  (define (sub newF n)
    (if (= n 1)
    newF
    (sub (compose f newF) (- n 1))))
  (sub f n))

(define (n-smoothed f dx n)
  (repeated (smooth f dx) n))

; Testing
((n-smoothed sin 0.2 4) (/ pi 2))
((n-smoothed sin 0.7 2) (/ pi 2))