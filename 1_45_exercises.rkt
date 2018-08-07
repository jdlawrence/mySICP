#lang sicp
(define tolerance 0.00001)

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (sqrt x)
  (fixed-point (lambda (y) (/ x y))
               1.0))

(define (square x) (* x x))
(define (cube x) (* x x x))

(define (average v1 v2)
  (/ (+ v1 v2) 2))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (define (sub newF n)
    (if (= n 1)
    newF
    (sub (compose f newF) (- n 1))))
  (sub f n))

(define (cube-root x)
  (fixed-point (average-damp (lambda (y) (/ x (square y))))
               1.0))

(define (fourth-root x)
  (fixed-point ((repeated average-damp 2) (lambda (y) (/ x (cube y)))) 
  ;(fixed-point (average-damp (average-damp (lambda (y) (/ x (cube y)))))
               1.0))

(define (fifth-root x)
  (fixed-point ((repeated average-damp 3) (lambda (y) (/ x (* y y y y)))) 
               1.0))

;(define (nth-power base exp)
;  ((repeated (lambda (x) (* base x)) exp) base))

(define (nth-power n)
  (define (sub iter result)
    (if (= iter 0)
        result
        (sub (- iter 1) (* n result))))
  (sub n 1))

(nth-power 5)

(define (nth-root x n)
;               ((repeated average-damp 3) (lambda (y) (/ x (* y y y y)   )))
  (fixed-point ((repeated average-damp (- n 2)) (lambda (y) (/ x (* y y y)      ))) 
               1.0))
  
(fourth-root 16)
(nth-root 16 4)
(fifth-root 32)