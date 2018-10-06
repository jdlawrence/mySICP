#lang racket
(define (make-interval a b) (cons a b))

(define (upper-bound interval) (cdr interval))
(define (lower-bound interval) (car interval))

#|
(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))
|#

(define (mul-interval x y)
    (let (
          (a (lower-bound x))
          (b (upper-bound x))
          (c (lower-bound y))
          (d (upper-bound y))
          (p1 (* (lower-bound x) (lower-bound y)))
          (p2 (* (lower-bound x) (upper-bound y)))
          (p3 (* (upper-bound x) (lower-bound y)))
          (p4 (* (upper-bound x) (upper-bound y)))
          )
  (cond ;1st three cases
        [(and (< a 0) (< b 0) (< c 0) (< d 0))
         (make-interval (* b d) (* a c))]
        [(and (< a 0) (< b 0) (< c 0) (> d 0))
         (make-interval (* a d) (* a c))]
        [(and (< a 0) (< b 0) (> c 0) (> d 0))
         (make-interval (* a d) (* b c))]
        ;2nd three cases
        [(and (< a 0) (> b 0) (< c 0) (< d 0))
         (make-interval (* b c) (* a c))]
        [(and (< a 0) (> b 0) (< c 0) (> d 0))
         (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))]
        [(and (< a 0) (> b 0) (> c 0) (> d 0))
         (make-interval (* a d) (* b d))]
        ;3rd three cases
        [(and (> a 0) (> b 0) (< c 0) (< d 0))
         (make-interval (* b c) (* a d))]
        [(and (> a 0) (> b 0) (< c 0) (> d 0))
         (make-interval (* b c) (* b d))]
        [(and (> a 0) (> b 0) (> c 0) (> d 0))
         (make-interval (* a c) (* b d))]
         )))

#| Testing |#
(define i1 (make-interval 1 2))
(define i2 (make-interval 2 4))
(mul-interval i1 i2)