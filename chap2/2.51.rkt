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

(paint einstein)
(paint (flip-horiz einstein))
(paint (180-degrees einstein))
(paint (270-degrees einstein))