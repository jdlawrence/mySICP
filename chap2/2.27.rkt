#lang racket
(define x (list (list 1 2) (list 3 4)))
(define easier (list (list 1 2) 3))
(define j (list 2 4 8 16))

(define (deep-reverse items)
  (cond ((null? items) items)
        ((pair? (car items)) (append (deep-reverse (cdr items)) (list (deep-reverse (car items)))))
        (else (append (deep-reverse (cdr items)) (list (car items))))))

#| Just for practice 
(define (length-j items)
  (define (sub items result)
    (if (null? items)
        result
        (sub (cdr items) (+ result 1))))
  (sub items 0))
|#
(reverse x)
(deep-reverse x)