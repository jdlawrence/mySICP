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

(define (45-degrees painter)
  ((transform-painter
    (make-vect 0.5 0.0) ; new origin
    (make-vect 1.0 0.5) ; new end of edge1
    (make-vect 0.0 0.5))
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

(define wave-segments
 (list
  (make-segment
   (make-vect 0.006 0.840)
   (make-vect 0.155 0.591))
  (make-segment
   (make-vect 0.006 0.635)
   (make-vect 0.155 0.392))
  (make-segment
   (make-vect 0.304 0.646)
   (make-vect 0.155 0.591))
  (make-segment
   (make-vect 0.298 0.591)
   (make-vect 0.155 0.392))
  (make-segment
   (make-vect 0.304 0.646)
   (make-vect 0.403 0.646))
  (make-segment
   (make-vect 0.298 0.591)
   (make-vect 0.354 0.492))
  (make-segment
   (make-vect 0.403 0.646)
   (make-vect 0.348 0.845))
  (make-segment
   (make-vect 0.354 0.492)
   (make-vect 0.249 0.000))
  (make-segment
   (make-vect 0.403 0.000)
   (make-vect 0.502 0.293))
  (make-segment
   (make-vect 0.502 0.293)
   (make-vect 0.602 0.000))
  (make-segment
   (make-vect 0.348 0.845)
   (make-vect 0.403 0.999))
  (make-segment
   (make-vect 0.602 0.999)
   (make-vect 0.652 0.845))
  (make-segment
   (make-vect 0.652 0.845)
   (make-vect 0.602 0.646))
  (make-segment
   (make-vect 0.602 0.646)
   (make-vect 0.751 0.646))
  (make-segment
   (make-vect 0.751 0.646)
   (make-vect 0.999 0.343))
  (make-segment
   (make-vect 0.751 0.000)
   (make-vect 0.597 0.442))
  (make-segment
   (make-vect 0.597 0.442)
   (make-vect 0.999 0.144))))


(define wave (segments->painter wave-segments))

#| Answer |#
(define wave-segments-j
 (list
  (make-segment
   (make-vect 0.006 0.840)
   (make-vect 0.155 0.591))
  (make-segment
   (make-vect 0.006 0.635)
   (make-vect 0.155 0.392))
  (make-segment
   (make-vect 0.304 0.646)
   (make-vect 0.155 0.591))
  (make-segment
   (make-vect 0.298 0.591)
   (make-vect 0.155 0.392))
  (make-segment
   (make-vect 0.304 0.646)
   (make-vect 0.403 0.646))
  (make-segment
   (make-vect 0.298 0.591)
   (make-vect 0.354 0.492))
  (make-segment
   (make-vect 0.403 0.646)
   (make-vect 0.348 0.845))
  (make-segment
   (make-vect 0.354 0.492)
   (make-vect 0.249 0.000))
  (make-segment
   (make-vect 0.403 0.000)
   (make-vect 0.502 0.293))
  (make-segment
   (make-vect 0.502 0.293)
   (make-vect 0.602 0.000))
  (make-segment
   (make-vect 0.348 0.845)
   (make-vect 0.403 0.999))
  (make-segment
   (make-vect 0.602 0.999)
   (make-vect 0.652 0.845))
  (make-segment
   (make-vect 0.652 0.845)
   (make-vect 0.602 0.646))
  (make-segment
   (make-vect 0.602 0.646)
   (make-vect 0.751 0.646))
  (make-segment
   (make-vect 0.751 0.646)
   (make-vect 0.999 0.343))
  (make-segment
   (make-vect 0.751 0.000)
   (make-vect 0.597 0.442))
  (make-segment
   (make-vect 0.597 0.442)
   (make-vect 0.999 0.144))

  ;New segments
  (make-segment
   (make-vect 0.475 0.7)
   (make-vect 0.525 0.7))
  
  (make-segment
   (make-vect 0.525 0.7)
   (make-vect 0.550 0.725))

  (make-segment
   (make-vect 0.450 0.725)
   (make-vect 0.475 0.7))
  ))

#| From earlier exercises |#
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))

#| old corner-split |#
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let ((top-left (beside up up))
              (bottom-right (below right right))
              (corner (corner-split painter (- n 1))))
          (beside (below painter top-left)
                  (below bottom-right corner))))))

#| My answer for a new corner-split |#
(define (corner-split-j painter n)
  (if (= n 0)
      painter
      (let ((up (up-split painter (- n 1)))
            (right (right-split painter (- n 1))))
        (let (
              (corner (corner-split painter (- n 1)))
              )
          (beside (below painter up)
                  (below right corner))))))

(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

#| My version of square-limit |#
(define (square-limit-j painter n)
  (let ((quarter (corner-split (45-degrees painter) n)))
    (let ((half (beside (flip-horiz quarter) quarter)))
      (below (flip-vert half) half))))

(paint (45-degrees einstein))

#| Testing |#

;(paint wave)
(define wave-j (segments->painter wave-segments-j))
(paint wave-j)
(paint (corner-split einstein 2))
(paint (corner-split-j einstein 2))
(paint (square-limit einstein 0))
(paint (square-limit einstein 1))
(paint (square-limit-j einstein 0))
(paint (square-limit-j einstein 1))
(paint (square-limit-j einstein 2))