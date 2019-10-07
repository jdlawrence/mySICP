#lang racket
#| Answer:

|#

(define (raise-integer->rational int)
  (make-rat int 1))

(define (raise-rational->real rat)
  (/ (numer rat) (denom rat)))

(define (raise-real->complex rn)
  (make-from-real-imag rn 0))

#|
To install each of these, use "put"
|#