#lang racket
(#%require sicp-pict)
#|
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))
|#

#| From 2.46 |#
(define (make-vect xcor ycor)
  (cons xcor ycor))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
             (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
             (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect scalar vect)
  (make-vect (* scalar (xcor-vect vect))
             (* scalar (ycor-vect vect))))   


#| Answers |#
(define (make-segment origin-start start-end)
  (cons origin-start start-end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

#| Testing |#
(define ex1 (make-segment (make-vect 0 4) (make-vect 4 9)))
(start-segment ex1) ;(0 4)
(end-segment ex1 ) ; (4 9)
