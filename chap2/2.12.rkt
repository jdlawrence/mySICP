#lang racket
(define (make-interval a b) (cons a b))

(define (upper-bound interval) (cdr interval))
(define (lower-bound interval) (car interval))

#| Answer |# 
(define (make-center-percent center percent)
  (make-interval (- center (* center (/ percent 100)))
                 (+ center (* center (/ percent 100)))))

#| Given: |#
(define (center i)
 (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (/ (- (upper-bound i) (center i)) (center i) 0.01))

#| Testing |#
(make-center-percent 100 5)
(center (make-interval 3 8))
(percent (make-interval 95 105))