#lang racket
(define (test val parity)
  (if (parity val)
      true
      false))

(test 2 odd?)

(append (list 1 2 ) (list 3 4))
