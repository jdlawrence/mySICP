#lang sicp
(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
#|
(+ 4 5)
  (if (= 4 5) #f
    (+ (
|#

(+ 4 5)