#lang sicp
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
 (lambda (f) (lambda (x) (f ((n f) x) ))))

; A function f applied once to our function
(define one (lambda (f) (f (lambda (x) x))))
(define two (lambda (f) (f (f (lambda (x) x)))))

(define (cool x) (+ x 2))
((zero cool) 2)

(let ((jamil 34)
     (akeem 32))
  (+ jamil akeem))

((lambda (x) (+ 1 x)) 4)
