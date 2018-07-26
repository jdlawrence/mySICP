#lang sicp
(odd? 3)
(define (pi num-iter)
  (define (sub i result)
    (cond ((= i num-iter) result)
          ((odd? i) (sub (+ i 1) (+ result (/ 1 (- (* 2 i) 1)))))
          (else (sub (+ i 1) (- result (/ 1 (- (* 2 i) 1)))))))
  (sub 1 0.0))

(* (pi 500) 4)

         
          