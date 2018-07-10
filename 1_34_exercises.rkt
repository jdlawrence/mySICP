#lang sicp
(define (f g)
  (g 2))

(define (square n) (* n n))

(f square)

; This results in an error because f is expects to be supplied with a procedue
(f 2)