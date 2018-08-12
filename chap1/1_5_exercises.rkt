#lang sicp
; Applicative Order: Simplify arguments first, then apply the procedure
; Ex:
; (define (add-to-2 x) (+ 2 x))
; (add-to-2 (+ 3 6))
; (add-to-2 9)
; (+ 2 9)
; 11
; Normal-order evaluation: Apply procedures first to get only primitives,
; evaluate
; Ex
; (add-to-2 (+ 3 6))
; (+ 2 (+ 3 6))
; (+ 2 9)
; 11
(define (p) (p))

(define (test x y) 
  (if (= x 0) 
      0 
      y))

(test 0 (p))
; In the above example with applicative order evaluation, the interpreter will
; keep trying to simplify (p) and replace it with (p). This will be an infinite
; loop.
; In normal-order evaluation, it would replace (test x y) with
; (if (= 0 0), which would evaluate to true and short circuit the fact of having
; to evaluate (p)
=======
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))
; ************ Alternative Answer ******************
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
