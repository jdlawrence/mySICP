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


#| NOTE: if the intervals spans 0, like (make-interval -2 2),
the reciprocal of the interval will be (make-interval 1/2 -1/2).
This has a higher lower bound than upper bound and doesn't
make sense
|#

(define (div-interval x y)
  (if (<= (* (upper-bound y) (lower-bound y)) 0) 
      (error "Error: Divide by 0")
  (mul-interval x
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y))))))

(define i3 (make-interval 0 10))
(define i4 (make-interval -2 0))

#| Testing |#
(div-interval i3 i4) ; Produce "Error: Divide by 0 