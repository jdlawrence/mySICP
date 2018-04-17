#lang sicp

(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
(count-change 11)


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