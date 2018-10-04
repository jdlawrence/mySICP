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

(define (div-interval x y)
  (if (or (= (upper-bound y) 0) (= (lower-bound y)))
      "Error Divide by 0"
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y))))))

(define i1 (make-interval 3 7))
(define i2 (make-interval -1 1))
(define i3 (make-interval 0 10))
(define i4 (make-interval -2 0))

(define (width interval)
  (/ (- (upper-bound interval)
        (lower-bound interval)) 2))

(mul-interval i3 i4)
(div-interval i3 i4)
#| Testing |#
(width (mul-interval i1 i2))
(width (mul-interval i3 i4))
#| Above widths are the same |#
