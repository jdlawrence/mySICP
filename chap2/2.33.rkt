#lang racket
(define nil '())

(define (j item) item)

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (items) (cons (car s) items)) rest)))))

(subsets (list 1 2 3))

(define (f x)
  ((lambda (a) (* a a))
   x))

;(f 1.3)

(define (map-square items)
  (map f items))

;(map-square (list 1 2 3 45))
  