#lang sicp
(define (make-interval a b) (cons a b))

(define (upper-bound interval) (cdr interval))
(define (lower-bound interval) (car interval))

(define (add-interval x y)
 (make-interval (+ (lower-bound x) (lower-bound y))
 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define i1 (make-interval 3 7))
(define i2 (make-interval 0 2))
(define i3 (make-interval -9 -5))
(define i4 (make-interval 11 13))

(define (width interval)
  (/ (- (upper-bound interval)
        (lower-bound interval)) 2))

#| Testing |#
(width (add-interval i1 i2))
(width (add-interval i3 i4))

(width (mul-interval i1 i2))
(width (mul-interval i3 i4))