#lang racket
;(define (count-pairs x)
#|
(define (count-pairs x)
  (define (sub item visited)
    (if (or (not (pair? item)) (memq item visited))
      0
      (+ (sub (car x) (cons item visited))
         (sub (cdr x) (cons item visited))
         1)))
  (sub x '()))
|#

#| Answer:
Have one function that goes through all of the pairs in any structure
Have another function that can check if a given pair is in a list
If the pair is in the list, keep going. If it's not in the list, cons
it to the beginning of the list. Return the length of the list when you have
reached the end of the structure
|#
(define (count-pairs x)
  (define (outer outer-visited)
    (define (sub item visited)
      (if (or (not (pair? item)) (memq item visited))
          0
          (begin
            (set! outer-visited (cons item outer-visited))
            (+ (sub (car x) outer-visited)
               (sub (cdr x) outer-visited)
               1))))
    (sub x outer-visited))
  (outer '())) 

; Another answer that uses "let". Probably more concise but I'm not yet used
; Scheme's usage of "let"
(define (count-pairs-2 x) 
   (let ((encountered '())) 
     (define (helper x) 
       (if (or (not (pair? x)) (memq x encountered)) 
         0 
         (begin 
           (set! encountered (cons x encountered)) 
           (+ (helper (car x)) 
              (helper (cdr x)) 
              1)))) 
   (helper x))) 


#| Testing |#
(define 1-pair (cons 'a 'b))
(define intermediate-2 (cons 1-pair 1-pair))
(define 3-pair-three (cons 'a (cons 'b (cons 'c '()))))
(define 4-pair-three (cons 'a intermediate-2))
(define 7-pair-three (cons intermediate-2 intermediate-2))

;(define ab (cons 'a (cons 'b '())))
(define ab '(a b))
(define ab-pair (cons ab ab))

(count-pairs 1-pair)
(count-pairs intermediate-2)
(count-pairs ab-pair)
(count-pairs 3-pair-three)
(count-pairs 4-pair-three)
(count-pairs 7-pair-three)

