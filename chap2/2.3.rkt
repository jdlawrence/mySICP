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

#|
4 points in clockwise order:
bottom-left, top-left, top-right, bottom-right |#
(define (make-rectangle-points p1 p2 p3 p4)
  (cons
   (cons p1 p2)
   (cons p3 p4)
        ))

#|
2 segments. Assuming rectangle has vertical sides:
One segment goes from bottom-left to top-left
Second segment goes from top-right to bottom-left
|#
(define (make-rectangle-segments s1 s2)
  (cons
    (cons (start-segment s1) (end-segment s1))
    (cons (start-segment s2) (end-segment s2))
    ))

(define (p1 rect)
  (car (car rect)))

(define (p2 rect)
  (car (cdr rect)))

(define (p3 rect)
  (cdr (car rect)))

(define (p4 rect)
  (cdr (cdr rect)))

(define (perimeter rect)
  (* 2 (+ (abs (- (x-point (p1 rect)) (x-point (p4 rect))))
          (abs (- (y-point (p1 rect)) (y-point (p2 rect))))
          )))

(define (area rect)
  (* (abs (- (x-point (p1 rect)) (x-point (p4 rect))))
     (abs (- (y-point (p1 rect)) (y-point (p2 rect))))
     ))

; Testing points
(define r1 (make-rectangle-points
            (make-point 0 0)
            (make-point 0 20)
            (make-point 4 20)
            (make-point 4 0)))

(perimeter r1)
(area r1)

; Testing segments
(define s1 (make-segment (make-point 0 0) (make-point 0 20)))
(define s2 (make-segment (make-point 4 20) (make-point 4 0)))

(define r2 (make-rectangle-segments s1 s2))

(perimeter r2)
(area r2)

;Test with a rectangle that doesn't have vertical sides
(define r3 (make-rectangle-points
            (make-point 0 0)
            (make-point -.707 .707)
            (make-point 0 1.414)
            (make-point .707 .707)))

(perimeter r3)
(area r3) 