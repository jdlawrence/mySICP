#lang sicp
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))


(sine 12.15)

#|
a) p is called 6 times because after the 6th call, p, the angle / 3 is
0.005, which is less than 0.1 and sufficiently small enough.
b) This is O(log(n)) because we're dividing a number of times
|#