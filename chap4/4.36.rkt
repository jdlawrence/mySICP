#lang sicp
#| Answer:
If we replace an-integer-between with an an-integer-starting-from, we will find the set of
all pythagorean triples because the innermost list, k, will keep going unboundedly, and
the i and j outer lists will never increment. 
|#
(define (a-pythagorean-triple-between n)
  (let ((i (an-integer-starting-from n)))
    (let ((j (an-integer-starting-from n)))
      (let ((k (an-integer-starting-from n)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))

#| Answer:
We need to increment the numbers in a manner where the i and j increase (as well as the k). To accomplish this,
I think we could use a procedure where typing "try-again" increases the upper
boundary of a call to a function I'll define called an-integer-up-to.
|#

(define (an-integer-up-to current high)
  (require (< current high))
  (amb current (an-integer-up-to (+ current 1) high)))


#| Every time "try-again" is pressed, we increase the value of "high" passed to all-pythagorean-triples
|#
(define (all-pythagorean-triples high)
  (let ((i (an-integer-starting-from 1)))
    (let ((j (an-integer-up-to 1 i)))
      (let ((k (an-integer-up-to 1 j)))
        (require (= (+ (* i i) (* j j)) (* k k)))
        (list i j k)))))
           
