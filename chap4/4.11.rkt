#lang racket
(define ns (make-base-namespace))

#| Answer:
Currently, we represent a frame as a pair of lists, like so:

(define (make-frame variables values)
  (cons variables values))

The variables are the "car" of the list and their values are the "cdr" of it.

|#

;We could change to something like this:
(define (make-frame variables values) 
  (map cons variables values))

;This would produce a list like this:
(list pair1 pair2 pair3)

;To get the name of one pair, we need the car of it, and to get the value we
;take the cdr

;To get all of the frame variables, we can map "car" to a frame
(define (frame-variables frame) (map car frame))

;To get all of the frame values, we can map "cdr" to a frame
(define (frame-variables frame) (map cdr frame))

;To add a frame, previously we just cons the variable and value on to their
;respective lists, but now we can the pair onto the list
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons (list var val) (car frame))))

;We also need to change set-variable-value! and define-variable-value!, in particular
;the assigment portion of both of those procedures. For set-variable-value, we would
;need some way to access a specific variable in a list. This could be done by iterating
;through the list of variables and counting how far you went, and then traveling that
;same distance in the values list. Or, you could use an assoc (association list)