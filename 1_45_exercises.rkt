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

(define (nTimes n x)
  (define (sub i result)
    (if (= i 0)
       result
       (sub (- i 1) (* x result))))
  (sub n 1))

;(nTimes 3 5)

; The number of average-damps turns out to be floor( log base2 of n)
(define (floor-log2 x) (floor (/ (log x) (log 2))))

(define (root n x)
  (fixed-point ((repeated average-damp (floor-log2 n)) (lambda (y) (/ x (nTimes (- n 1) y)))) 
               1.0))
  
(fourth-root 16)
(root 4 256)
(fifth-root 32)
(root 32 4294967296)
(root 32 4294967296)