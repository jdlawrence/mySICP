#lang sicp
(#%require sicp-pict)
#|
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))
|#

#| Answers |#
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

#| Testing |#
(make-vect 2 3)
(define ex1 (make-vect 4 9))
(define ex2 (make-vect 11 14))
(xcor-vect ex1)
(ycor-vect ex2)
(add-vect ex1 ex2)
(sub-vect ex1 ex2)
(scale-vect 3 ex1)