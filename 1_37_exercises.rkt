#lang sicp
;(/ 1 (+ 1 (/ 1 1)))
;(/ 1 (+ 1 (/ 1 (+ 1 (/ 1 1)))))

;(define (cont-frac n d k)

(define (plus8 n)
  (
   (lambda (n) (+ n 8))
   n
  ))

;(plus8 2)

(define (cont-frac n d k)
  (define (sub n k count)
    (if (= count k)
        0
        (/ 1.0 (+ 1.0 (sub n k (+ count 1)))))) 
  (sub n k 0))

(/ 1 (cont-frac 1 1 25))

;(define k 10)
;(cont-frac (lambda (i) 1.0)
;           (lambda (i) 1.0)
;           k)