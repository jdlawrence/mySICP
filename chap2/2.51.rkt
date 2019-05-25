#lang racket
;(require (planet "sicp.ss" ("soegaard" "sicp.plt" 2 1)))
(require sicp-pict)

#| Answer |#
(define (flip-horiz painter)
  ((transform-painter 
    (make-vect 1.0 0.0) ; new origin
    (make-vect 0.0 0.0) ; new end of edge1
    (make-vect 1.0 1.0))
   painter)) ; new end of edge2

(define (90-degrees painter)
  ((transform-painter
    (make-vect 1.0 0.0) ; new origin
    (make-vect 1.0 1.0) ; new end of edge1
    (make-vect 0.0 0.0))
   painter)) ; new end of edge2

(define (180-degrees painter)
  ((transform-painter
    (make-vect 1.0 1.0) ; new origin
    (make-vect 0.0 1.0) ; new end of edge1
    (make-vect 1.0 0.0))
   painter)) ; new end of edge2

(define (270-degrees painter)
  ((transform-painter 
    (make-vect 0.0 1.0) ; new origin
    (make-vect 0.0 0.0) ; new end of edge1
    (make-vect 1.0 1.0))
   painter)) ; new end of edge2

(define (f x y)
  (let ((a (+ 1 (* x y)))
        (b (- 1 y)))
    (+ (* x (* a a))
       (* y b)
       (* a b))))

#| Using my version of "beside" and not the built in one |#
(define (beside-j painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left
           ((transform-painter
            (make-vect 0.0 0.0)
            split-point
            (make-vect 0.0 1.0))
            painter1))
           
          (paint-right
           ((transform-painter
            split-point
            (make-vect 1.0 0.0)
            (make-vect 0.5 1.0))
            painter2))
           )
      (lambda (frame)
        (paint-left frame)
        (paint-right frame)))))

#| Answer |#
(define (below-j painter1 painter2)
  (let ((split-point (make-vect 0.0 0.5)))
    (let ((paint-above
           ((transform-painter
             split-point
            (make-vect 1.0 0.5)
            (make-vect 0.0 1.0))
            painter1))
           
          (paint-below
           ((transform-painter
            (make-vect 0.0 0.0)
            (make-vect 1.0 0.0)
            split-point)
            painter2))
           )
      (lambda (frame)
        (paint-above frame)
        (paint-below frame)))))

(define (below-from-rotations painter1 painter2)
  (90-degrees (beside-j (270-degrees painter1) (270-degrees painter2))))

#| Testing |#
(paint (below-j einstein einstein))
(paint (below-from-rotations einstein einstein))
