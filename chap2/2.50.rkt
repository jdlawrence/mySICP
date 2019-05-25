#lang racket/gui
(require graphics/graphics)
(open-graphics)
(define vp (open-viewport "A Picture Language" 500 500))

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

#| From 2.47 |#
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (car (cdr frame)))

(define (edge2-frame frame)
  (car (cdr (cdr frame))))

(define (frame-coord-map frame)
  (lambda (v)
    (add-vect
     (origin-frame frame)
     (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
               (scale-vect (ycor-vect v) (edge2-frame frame))))))

#| From 2.48 |#
(define (make-segment origin-start start-end)
  (cons origin-start start-end))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

#| From https://stackoverflow.com/questions/13592352/compiling-sicp-picture-exercises-in-drracket |#
(define draw (draw-viewport vp))
(define (clear) ((clear-viewport vp)))
(define line (draw-line vp))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (let ((start-coord-map ((frame-coord-map frame) (start-segment segment)))
             (end-coord-map ((frame-coord-map frame) (end-segment segment))))
       (line
        (make-posn (xcor-vect start-coord-map) (ycor-vect start-coord-map))
        (make-posn (xcor-vect end-coord-map) (ycor-vect end-coord-map)))))
     segment-list)))

#| From 2.49 |#

(define wave ((segments->painter (list
                     (make-segment (make-vect .25 0) (make-vect .35 .5)) 
                     (make-segment (make-vect .35 .5) (make-vect .3 .6)) 
                     (make-segment (make-vect .3 .6) (make-vect .15 .4)) 
                     (make-segment (make-vect .15 .4) (make-vect 0 .65)) 
                     (make-segment (make-vect 0 .65) (make-vect 0 .85)) 
                     (make-segment (make-vect 0 .85) (make-vect .15 .6)) 
                     (make-segment (make-vect .15 .6) (make-vect .3 .65)) 
                     (make-segment (make-vect .3 .65) (make-vect .4 .65)) 
                     (make-segment (make-vect .4 .65) (make-vect .35 .85)) 
                     (make-segment (make-vect .35 .85) (make-vect .4 1)) 
                     (make-segment (make-vect .4 1) (make-vect .6 1)) 
                     (make-segment (make-vect .6 1) (make-vect .65 .85)) 
                     (make-segment (make-vect .65 .85) (make-vect .6 .65)) 
                     (make-segment (make-vect .6 .65) (make-vect .75 .65)) 
                     (make-segment (make-vect .75 .65) (make-vect 1 .35)) 
                     (make-segment (make-vect 1 .35) (make-vect 1 .15)) 
                     (make-segment (make-vect 1 .15) (make-vect .6 .45)) 
                     (make-segment (make-vect .6 .45) (make-vect .75 0)) 
                     (make-segment (make-vect .75 0) (make-vect .6 0)) 
                     (make-segment (make-vect .6 0) (make-vect .5 .3)) 
                     (make-segment (make-vect .5 .3) (make-vect .4 0)) 
                     (make-segment (make-vect .4 0) (make-vect .25 0))))
 (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500))))


(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                  new-origin
                  (sub-vect (m corner1) new-origin)
                  (sub-vect (m corner2) new-origin)))))))

(define (flip-vert painter)
  (transform-painter painter
                     (make-vect 0.0 1.0) ; new origin
                     (make-vect 1.0 1.0) ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2

(define (shrink-to-upper-right painter)
  (transform-painter
   painter (make-vect 0.5 0.5)
   (make-vect 1.0 0.5) (make-vect 0.5 1.0)))

(shrink-to-upper-right wave)
((shrink-to-upper-right wave) (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))
;(shrink-to-upper-right (make-frame (make-vect 0 500) (make-vect 500 0) (make-vect 0 -500)))

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
                     (make-vect 1.0 0.0) ; new origin
                     (make-vect 1.0 1.0) ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2