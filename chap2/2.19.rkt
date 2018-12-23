#lang racket
#| Old version from 1.2.2 
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
|#

#| 
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
|#

(define us-coins (list 25 50 10 5 1))

(define (first-denomination aList)
  (car aList))

(define (except-first-denomination aList)
  (cdr aList))

(define (no-more? aList)
  (null? aList))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))
#| ***** Answer *****
The order of the coins does not matter because eventually all coins will be used
|#


#| Testing |#
(first-denomination us-coins) ; 50
(except-first-denomination us-coins) ; (25 10 5 1)
(no-more? us-coins) ; false
(no-more? (list)) ; true

(cc 100 us-coins)