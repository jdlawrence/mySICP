#lang racket
(define (accumulate op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (accumulate op initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))