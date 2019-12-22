#lang racket
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;(define ex (list 'a 'b 'c 'd))
(define ex (list 'a 'b))

(count-pairs ex)
