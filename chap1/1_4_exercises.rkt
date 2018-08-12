#lang sicp
; Sums two numbers; one number and the absolute value of another one
; Adds 'a' and if b is greater than 0, adds b, otherwise subtracts b
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;If b is greater than 0, add b, otherwise it's negative, so subtract
(a-plus-abs-b 4 8)
