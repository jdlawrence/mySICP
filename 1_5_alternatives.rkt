#lang racket
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