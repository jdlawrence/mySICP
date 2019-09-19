#lang racket
;(define (equ? num1 num2)
;  (cond (
(define (equ? x y) (apply-generic 'equ? x y))

(eq? 'j 'j)
(eq? 'j 'k)