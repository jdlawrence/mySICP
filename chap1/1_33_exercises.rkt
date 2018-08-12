#lang sicp
(define (inc a)
  (+ a 1))

(define (identity a) a)

(define (pi-prod-term n)
  (/ (* (* 2.0 n) (+ 2 (* 2 n)))
     (* (+ (* 2 n) 1) (+ (* 2 n) 1))))

;Iterative version of accumulate
(define (accumulate combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

;Recursive version of accumulate
(define (accumulate-r combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-r combiner null-value term (next a) next b))))

(define (sum-accum term a next b)
  (accumulate + 0 term a next b))

(define (mult-accum term a next b)
  (accumulate * 1 term a next b))

;(sum-accum identity 1 inc 10)

; Iterative version of filter-accumulate
(define (filter-accumulate combiner null-value term a next b filter?)
  (define (iter a result)
    (if (> a b)
        result
        (if (filter? a)
            (iter (next a) (combiner (term a) result))
            (iter (next a) result))))
  (iter a null-value))

; Recursive version of filter-accumulate
(define (filter-accumulate-r combiner null-value term a next b filter?)
  (if (> a b)
      null-value
      (if (filter? a)
          (combiner (term a) (filter-accumulate-r combiner null-value term (next a) next b filter?))
          (filter-accumulate-r combiner null-value term (next a) next b filter?))))

(define (odd? n)
  (= (remainder n 2) 1))

(define (even? n)
  (not (odd? n)))

; Tests
#|
(even? 3)
(even? 4)
(filter-accumulate + 0 identity 1 inc 10 odd?) ;25
(filter-accumulate-r + 0 identity 1 inc 10 odd?) ;25
(filter-accumulate * 1 identity 1 inc 10 even?) ;3840
|#

;******** Helper functions ********
(define (square n)
  (* n n))
(define (smallest-div n) 
    (define (divides? a b) 
      (= 0 (remainder b a))) 
    (define (find-div n test) 
       (cond ((> (square test) n) n) ((divides? test n) test) 
             (else (find-div n (+ test 1))))) 
    (find-div n 2)) 
  
   (define (prime? n) 
     (if (= n 1) false (= n (smallest-div n)))) 
;********** End helper functions ****************

;a) the sum of the squares of the prime numbers in the interval a to b
(define (sum-square-primes a b)
  (filter-accumulate + 0 square a inc b prime?))

(sum-square-primes 1 5)

;b)The product of all the positive integers less than n that are relatively prime to n
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (prod-pos-relative-primes n)
  (define (relatively-prime? a)
    (= (gcd a n) 1))
  (filter-accumulate * 1 identity 2 inc (- n 1) relatively-prime?))

(prod-pos-relative-primes 10)



