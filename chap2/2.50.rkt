#lang racket
#| Answer |#
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0.0) ; new origin
                     (make-vect 1.0 1.0) ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2

(define (180-degrees painter)
  (transform-painter painter
                     (make-vect 1.0 1.0) ; new origin
                     (make-vect 0.0 1.0) ; new end of edge1
                     (make-vect 1.0 0.0))) ; new end of edge2

(define (270-degrees painter)
  (transform-painter painter
                     (make-vect 0.0 1.0) ; new origin
                     (make-vect 1.0 1.0) ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2