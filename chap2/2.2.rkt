#lang sicp
(define (make-point x y)
  (cons x y))

(define (x-point pt)
  (car pt))

(define (y-point pt)
  (cdr pt))

(x-point (make-point 2 3))
(y-point (make-point 2 3))

#|
(define (make-segment pt1 pt2)
  (cons (make-point (x-point pt1) (y-point pt1))
        (make-point (x-point pt2) (y-point pt2))))
|#

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

(print-point (make-point 2 3))

(define s1 (make-segment (make-point 0 0) (make-point 2 3)))

(start-segment s1)
(end-segment s1)

; Actual answer:
(define (midpoint-segment segment)
  (make-point (/ (+ (x-point (start-segment segment))
                    (x-point (end-segment segment))) 2)
              (/ (+ (y-point (start-segment segment))
                    (y-point (end-segment segment))) 2)))

(print-point (midpoint-segment s1))