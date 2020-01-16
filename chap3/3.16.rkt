#lang sicp
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

#| Answer:
Ben Biddlecome's answer doesn't account for nested structures
where the car and cdr point to the same pair
|#

#| Testing |#
(define 1-pair (cons 'a 'b))
(define intermediate-2 (cons 1-pair 1-pair))
(define 3-pair-three (cons 'a (cons 'b (cons 'c '()))))
(define 4-pair-three (cons 'a intermediate-2))
(define 7-pair-three (cons intermediate-2 intermediate-2))
                                                   
(count-pairs 1-pair)
(count-pairs intermediate-2)
(count-pairs 3-pair-three)
(count-pairs 4-pair-three)
(count-pairs 7-pair-three)

(define infinite (cons 'a (cons 'b (cons 'c '()))))
(set-cdr! (cddr infinite) infinite)
(count-pairs infinite) ;Never returns 
