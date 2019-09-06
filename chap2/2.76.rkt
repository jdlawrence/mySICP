#lang racket

#| Given: |#
(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude) (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else (error "Unknown op: MAKE-FROM-REAL-IMAG" op))))
  dispatch)

#| Answer: |#
(define (make-from-mag-angle mag angle)
  (define (dispatch op)
    (cond ((eq? op 'real-part) (* mag (cos angle)))
          ((eq? op 'imag-part) (* mag (sin angle)))
          ((eq? op 'mag) mag) 
          ((eq? op 'angle) angle)
          (else (error "Unknown op: MAKE-FROM-MAG-ANGLE" op))))
  dispatch)

#| Answer:

|#