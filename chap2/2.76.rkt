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
(define (real-part z)
  (cond ((rectangular? z)
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        (else (error "Unknown type: REAL-PART" z))))
#| Answer:
In the generic operations with explicity detail strategy, you must create a whole new
series of functions per type that is added. For example, if we already have real-part-rectangular
and real-part-polar, and we wanted to add a new type, say "crazy", we have to create
real-part-crazy and also go and add it to the function that selects the appropriate real-part
function, ie:
(define (real-part z)
  (cond ((rectangular? z)
         (real-part-rectangular (contents z)))
        ((polar? z)
         (real-part-polar (contents z)))
        ((crazy? z)
         (real-part-crazy (contents z)))
        (else (error "Unknown type: REAL-PART" z))))
This is not convenient in either adding operations or types.


|#