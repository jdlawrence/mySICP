#lang racket
(define (equ? x y) (apply-generic 'equ? x y))

#| Inside the scheme-number package |#
(define (zero?-scheme x)
  (= 0 x))
#| Install in numbers generic package |#
(put 'zero? '(rational-number)
  (lambda (x) (zero?-scheme x)))


#| Inside the scheme-number package |#
(define (zero?-rational x)
  (and (= 0 (numer x))))
#| Install in numbers generic package |#
(put 'zero? '(rational-number)
  (lambda (x) (zero?-rational x)))

#| Inside the complex-number package |#
(define (zero?-complex x)
  (and (= 0 (real-part x))
       (= 0 (imag-part x))))
#| Install in numbers generic package |#
(put 'zer0? '(complex-number)
  (lambda (x) (zero?-complex x)))
