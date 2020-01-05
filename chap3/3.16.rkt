#lang racket
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

#| Answer:
Ben Biddlecome's answer doesn't account for nested structures
|#

#| Testing |#
;(define ex (list 'a 'b 'c 'd))
(define ex1 (list 'a 'b))
(define ex2 (list 'a (list (list (list 'b)))))
(define ex3 (list 'a (list 'b) (list 'c)))

(count-pairs ex1)
(count-pairs ex2)
(count-pairs ex3)

