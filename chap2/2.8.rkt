#lang sicp
(define (make-interval a b) (cons a b))

(define (upper-bound interval) (cdr interval))
(define (lower-bound interval) (car interval))

#|
By general reasoning, subtracting one interval from another should be the same
thing as adding the negative. For exmaple:
[4, 7] - [1, 3] =
[4, 7] + [-3, -1] = 
[1, 6]

NOTE: To find the negative, you must flip the interval over x = 0. Ex:
negative of [2, 8] = [-8, -2]
negative of [-3, 5] = [-5, 3]
negative of [-6, -2] = [2, 6]

Shortcut to this pattern:
[a, b] - [c, d] =
[a, b] + [-d, -c] =
[a - d, b - c]

|#
(define (add-interval x y)
 (make-interval (+ (lower-bound x) (lower-bound y))
 (+ (upper-bound x) (upper-bound y))))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(define i1 (make-interval 3 7))
(define i2 (make-interval 0 2))

#| Testing |#
(sub-interval i1 i2)
(sub-interval i2 i1)