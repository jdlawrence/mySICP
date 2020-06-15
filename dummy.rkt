#lang sicp
(define (try-out arg1 . arglist)
  ;(display arglist))
  (display arg1))
  
(try-out "first-arg" 1 2 3 4 5)

(apply + (list 1 2 3 4 5 6))