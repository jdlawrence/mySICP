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

;(sum-cubes 1 400000)

; Recursive Approach
(define (prod-r term a next b)
  (if (> a b)
      1
      (* (term a) (prod term (next a) next b))))
                   
; Iterative Approach
(define (prod term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* result (term a)))))
  (iter a 1))

(define (identity a) a)

(define (factorial a)
  (prod identity 1 inc a))

(define (factorial-r a)
  (prod identity 1 inc a))

;(factorial 6)
;(factorial-r 6)

(define (pi-prod-term n)
  (/ (* (* 2.0 n) (+ 2 (* 2 n)))
     (* (+ (* 2 n) 1) (+ (* 2 n) 1))))

(define (pi-over-four)
  (prod pi-prod-term 1 inc 10000000))

(* 4 (pi-over-four))