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

(define (make-center-percent center percent)
  (make-interval (- center (* center (/ percent 100)))
                 (+ center (* center (/ percent 100)))))

#| Given: |#
(define (center i)
 (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (/ (- (upper-bound i) (center i)) (center i) 0.01))

(define i1 (make-center-percent 500 3))
(define i2 (make-center-percent 400 1))

(define (mul-interval2 x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval p1 p4)))

(percent (mul-interval i1 i2))
(percent (mul-interval2 i1 i2))

#|
From the tests above, my hypothesis is that the percentage of the
product is the sum of the individual percentages

c1 = center of interval 1
c2 = center of interval 2
p1 = percentage of interval 1
p2 = percentage of interval 2

[c1(1-p1), c1(1+p1)] * [c2(1-p2), c2(1+p2)]

By definition of multiplication, when all numbers are positive, the
product interval is the product of the lower bounds times and the product
of the upper bounds

[c1c2(1-p1)(1-p2), c1c2(1+p1)(1+p2)]

Multiplying this out:
[c1c2(1 - p1 - p2 - p1p2), c1c2(1 + p1 + p2 + p1p2)]

Since p1 and p2 are small, p1p2 will go to zero.
[c1c2(1 - p1 - p2), c1c2(1 + p1 + p2)]

A percentage can be defined as (upper - center)/ center

The center of above interval is:
(2c1c2)/2 = c1c2

Therefore, we can write:
(c1c2(1 + p1 + p2) - c1c2) / (c1c2)
or
1 + p1 + p2

This means the final percentage is equal to p1 + p2
|#