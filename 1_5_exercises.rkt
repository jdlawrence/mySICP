#lang sicp
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))
;Using Applicative-order, this will cause an infinite loop.
; (p) is in parenthesis, and it will try to expand,
; but since it is defined as (p), it will never reach it expand infinitely
; Lisp uses Applicative-order, and this will never terminate
(test 0 (p))

; Uses Normal-order, the definition of test will expand,
; and through short-circuit evaluation, the first argument of the 'if'
; statement will be true, and we won't have to worry about the definition of (p)
; (test 0 (p))
; (if (= 0 0) 0 (p))
; (if #t 0 (p))
; 0