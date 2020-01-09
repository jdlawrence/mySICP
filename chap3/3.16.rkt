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
(define ex2 (list (list 'a) 'a))
(define ex3 (list 'a (list 'b) (list 'c)))



(car ex2)
(cdr ex2)
(count-pairs ex1)
(count-pairs ex2)
(count-pairs ex3)

(define x (list 'a 'b))
(define z1 (cons x x))
(define z2 (list x x))

(car z1)
(cdr z1)
(car z2)
(cadr z2)
(cons 1 (cons 2 3))

(cons 1 2)
'(1 . 2)