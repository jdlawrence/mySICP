#lang sicp
 ;(define (pascal r c)) 
  
 ;; Testing 
#| (pascal 1 1) 
 (pascal 2 2) 
 (pascal 5 3) |#

(define (fact n)
  (define (sub total curr limit)
    (cond ((= limit 1) 1)
          ((> curr limit) total)
          (else (sub (* total curr) (+ curr 1) limit))))
  (sub 1 1 n))

(fact 2)

(define (comb n r)
  (/ (fact n) (* (fact (- n r)) (fact r))))

(comb 5 0)

#| NOTE (rows and columns start from 0)
This method uses the fact that any position in Pascal's Triangle can be
found by finding binomial coefficients. These are given by nCr, the formula
for a combination of "n choose r" elements. This formula is:
nCr = n! / ((n-r)! * r!)
For example, if you have 5 marbles to choose from, and you want to choose 2, you
have nCr(5,2) = 6 ways to do so. These are same coefficients as in Pascal's triangle.
|#
(define (pascal r c)
  (comb (- r 1) (- c 1)))

(pascal 5 3)