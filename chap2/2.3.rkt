#lang sicp
(define (make-point x y)
  (cons x y))

(define (x-point pt)
  (car pt))

(define (y-point pt)
  (cdr pt))

(define (make-segment pt1 pt2)
  (cons pt1 pt2))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (print-point p)
 (newline)
 (display "(")
 (display (x-point p))
 (display ",")
 (display (y-point p))
 (display ")"))

; With 4 points
; (in clockwise order from bottom left
(define (make-rectangle p1 p2 p3 p4)
  (cons (cons p1 p2) (cons p3 p4)))

(define (perimeter rect)
  (+ (abs (- (x-point (car
