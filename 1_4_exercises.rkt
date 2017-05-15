#lang sicp
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;If b is greater than 0, add b, otherwise it's negative, so subtract
(a-plus-abs-b 4 8)