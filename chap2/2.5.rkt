#lang sicp
(define (square n) (* n n))

#| We need to define exponent |#
(define (expt base pow)
  (define (sub base pow result)
    (cond ((= pow 0) result)
          ((odd? pow) (sub base (- pow 1) (* base result)))
          (else (sub (square base) (/ pow 2) result))))
  (sub base pow 1))

#| Defines how many times the base divides n with no remainder |#
(define (wholePow base n)
  (define (sub base quotient count)
    (cond ((= (remainder quotient base) 0) (sub base (/ quotient base) (+ count 1)))
          (else count)))
  (sub base n 0))

;(wholePow 3 24)
;(expt 2 4)

#| Short for "cons as exponents" |#
(define (eCons x y)
  (* (expt 2 x) (expt 3 y)))

(define (eCar pair)
  (wholePow 2 pair))

(define (eCdr pair)
  (wholePow 3 pair))

#| Testing |#
(eCons 3 1) ; returns 24
(eCar (eCons 3 1)) ; returns 3
(eCdr (eCons 3 8)) ; return 8
