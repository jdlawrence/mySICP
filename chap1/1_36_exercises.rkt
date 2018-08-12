#lang sicp
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess count)
    (display count)
    (display " ")
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next (+ 1 count)))))
  (try first-guess 0))

(define (golden-ratio a)
  ((lambda (x) (+ 1 (/ 1.0 x)))
  a))


(define (x-to-x a)
  (/ (log 1000) (log a)))

(define (x-to-x-dampen a)
  (/ (+ (/ (log 1000) (log a)) a) 2))

#|
In both the regular and average-dampened function,
the solution is ~4.55553. However the average-dampened
function gets there about 4 times faster!
|#
(fixed-point x-to-x 4)
(fixed-point x-to-x-dampen 2)