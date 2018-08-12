#lang sicp
(define (double proc)
  (lambda (x) (proc (proc x))))

(define (inc x)
  (+ x 1))

(inc 3)
((double inc) 3)

; Our answer
(define (compose f g)
  (lambda (x) (f (g x))))

; Testing
(define (square x) (* x x))
((compose square inc) 6)
