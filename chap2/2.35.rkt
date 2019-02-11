#lang racket
(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

#| My answer |#
(define (count-leaves-alt t)
  (define (counter item)
    (cond ((null? item) 0)
          ((not (pair? item)) 1)
          (else (count-leaves-alt item))))
  (accumulate + 0 (map counter t)))

#| The earlier answer from 2.2.2 |#
(define (count-leaves x)
   (cond ((null? x) 0)
         ((not (pair? x)) 1)
         (else (+ (count-leaves (car x))
                  (count-leaves (cdr x))))))

#| Testing |#
(define ex1 (list (list 1 2) 3 4))
(define ex2 (list 3 4 5 (list 6 (list 7 8) 9)))
(define ex3 (list (list 1 2) (list 1 2 3) 1)) 
(count-leaves ex1)
(count-leaves ex2)
(count-leaves-alt ex1)
(count-leaves-alt ex2)
(count-leaves-alt ex3)