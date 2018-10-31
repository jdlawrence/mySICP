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
 (mul-interval x
 (make-interval (/ 1.0 (upper-bound y))
 (/ 1.0 (lower-bound y)))))

(define (make-center-percent center percent)
  (make-interval (- center (* center (/ percent 100)))
                 (+ center (* center (/ percent 100)))))

#| Given: |#
(define (center i)
 (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (/ (- (upper-bound i) (center i)) (center i) 0.01))

(define i1 (make-center-percent 500 2))
(define i2 (make-center-percent 500 3))

(define (par1 r1 r2)
 (div-interval (mul-interval r1 r2)
               (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))


#| Testing |#
(percent (par1 i1 i2)) ;Produces a 3 percent interval when inputs are 1%
(percent (par2 i1 i2)) ;Produces a 1 percent interval when inputs are 1%
(par1 i1 i2)
(par2 i1 i2)

(percent (add-interval i1 i2)) ; Percent stays the same
(percent (div-interval i1 i2)) ; Percent doubles
(percent (mul-interval i1 i2)) ; Percent doubles
#| Answer:

It appears that par1 produces an interval that is three times as great as
par2. I believe this is because it has more calculations involving intervals,
meaning more operations. In par1, there's one multiplication, which adds the
two interval percentages together, one division, which adds the intervals
together, and one sum, which averages the intervals. In par2, there is only
one sum.

|#