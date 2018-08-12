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

(sum-accum identity 1 inc 10)

(mult-accum identity 1 inc 6)

(* 4 (mult-accum pi-prod-term 1 inc 1000000)) 