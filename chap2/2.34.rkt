#lang racket
(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff)) 
              0
              coefficient-sequence))

#|
This works because Horner evaluation uses the highest power, or last in the coefficient list, first.
With recursion, we end using each value from the coefficient list in reverse order
Higher-terms refers to the result so far, so we multiply the result so far by x, and then add the coefficient
of the next lowest term.
Ex:
given a coefficient list of 1 3 0 4 at x=2,

((((4*2 + 0)*2 + 3)*2 + 1)

|#

(horner-eval 2 (list 1 3))
(horner-eval 2 (list 1 3 0 5 0 1))
(horner-eval 2 (list 1 3 0 4))
;(accumulate + 0 (list 1 2 3 4 5))
;(accumulate * 1 (list 1 2 3 4 5))
