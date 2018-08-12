#lang sicp
(define (double proc)
  (lambda (x) (proc (proc x))))

(define (inc x)
  (+ x 1))

; Useful helper function
(define (square x) (* x x))
(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (sub newF n)
    (if (= n 1)
    newF
    (sub (compose f newF) (- n 1))))
  (sub f n))

((repeated inc 9) 5)

((repeated square 2) 5)

