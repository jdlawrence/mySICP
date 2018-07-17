#lang sicp
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

;(fixed-point cos 1.57)

;(let ( (x 3) )
;  (+ x (/ 1 x)))

;((lambda (x) (+ x (/ 1 x))) 3)

(define (golden-ratio a)
  ((lambda (x) (+ x (/ 1.0 x)))
  a))
;(golden-ratio 3)

(fixed-point golden-ratio 1.0)