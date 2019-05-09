#lang racket
(#%require sicp-pict)

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


#| Given using a list |#
#|
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
|#

#| Given using cons |#
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))


#| Answers |#
#| If using a list |#
#|
(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))
|#

#| If using cons |#
(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (cdr (cdr frame)))


(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))

(define a-frame (make-frame (make-vect 0 0) (make-vect 1 0) (make-vect 0 1)))

((frame-coord-map a-frame) (make-vect 0 0))
(origin-frame a-frame)

#| Testing |#
(define jamil (cons 1 (cons 2 3)))
(car jamil)
(car (cdr jamil))
(cdr (cdr jamil))