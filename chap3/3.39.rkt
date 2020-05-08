#lang sicp
(define x 101)
(define s (make-serializer))


(parallel-execute
 (s (lambda () (set! x (* x x))))
 (s (lambda () (set! x (+ x 1)))))

(parallel-execute
 (lambda ()
   (set! x ((s (lambda () (* x x)))))) ; This is a function that sets x to be the square of itself
 (s (lambda () (set! x (+ x 1)))))

#| Answer
4 of the five values are possible:

101: P1 sets x to 100 and then P2 increments x to 101.
121: P2 increments x to 11 and then P1 sets x to x * x.
11: P2 accesses x, then P1 sets x to 100, then P2 sets x.
100: P1 accesses x (twice), then P2 sets x to 11, then P1 sets x.


Only 110 is no longer possible. The following condition:
"110: P2 changes x from 10 to 11 between the two times that
P1 accesses the value of x during the evaluation of (* x x)."

can no longer happen because the squaring of x is serialized.

|#


