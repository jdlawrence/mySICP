#lang racket
;(define (equ? num1 num2)
;  (cond (
(define (equ? x y) (apply-generic 'equ? x y))

#| Inside the scheme-number package |#
(define (equ?-scheme x y)
  (= x y))
#| Install in numbers generic package |#
(put 'equ? '(rational-number rational-number)
  (lambda (x y) (equ?-scheme x y)))


#| Inside the scheme-number package |#
(define (equ?-rational x y)
  (and (= (numer x) (numer y))
       (= (denom x) (denom y))))
#| Install in numbers generic package |#
(put 'equ? '(rational-number rational-number)
  (lambda (x y) (equ?-rational x y)))

#| Inside the complex-number package |#
(define (equ?-complex x y)
  (and (= (real-part x) (real-part y))
       (= (imag-part x) (imag-part y))))
#| Install in numbers generic package |#
(put 'equ? '(complex-number complex-number)
  (lambda (x y) (equ?-complex x y)))
