#lang racket
; Sums two numbers; one number and the absolute value of another one
; Adds 'a' and if b is greater than 0, adds b, otherwise subtracts b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
