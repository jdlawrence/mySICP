#lang sicp
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

;(* 8 (pi-sum 1 2000000))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (inc a)
  (+ a 1))

(define (cube a)
  (* a a a))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 4)

(define (factorial n)
 (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
 (if (> counter max-count)
 product
 (fact-iter (* counter product)
 (+ counter 1)
 max-count)))

(factorial 4)