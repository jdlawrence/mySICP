#lang sicp
(define (make-interval a b) (cons a b))

; Answer
(define (upper-bound interval) (cdr interval))
(define (lower-bound interval) (car interval))

; Testing
(upper-bound (make-interval 9 11))
(lower-bound (make-interval 9 11))