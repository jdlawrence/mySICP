#lang sicp
(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ result (term a))))) 
  (iter a 0))

(define (inc a)
  (+ a 1))

(define (cube a)
  (* a a a))

(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 400000)

(define (pi-sum a b) 
  (define (pi-term x) 
          (/ 1.0 (* x (+ x 2)))) 
  (define (pi-next x) 
          (+ x 4)) 
  (sum pi-term a pi-next b))

(* 8 (pi-sum 1 2000000))

