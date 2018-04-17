#lang sicp
(define (cube x) (* x x x))
(define (p x) (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
   (if (not (> (abs angle) 0.1))
       angle
       (p (sine (/ angle 3.0)))))


(sine 12.15)

#|
To make 11, there are 4 methods. They are:
eleven 1s;
one 5, six 1s;
two 5s, one 1;
one 10, one 1;
Each of these methods requires calling (cc amount kind-of-coins) some fraction of n times.
This is done for each of the k number of coins. Therefore the space used is O(n), where n is
the amount we're making change for, and time is O(n ^ k), where n is the amount we're making
change for, and k is the amount of types of coins.
|#