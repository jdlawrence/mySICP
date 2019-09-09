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

Data-Driven style consists of table where each row has an operation (like "magnitude") and each type's
variation on that operation, ie magnitude for polar, magnitude for rectangular, etc. To add to this
style, we'd need a new column to the table, which would running the apply-generic procedure with the
updated package. Each package would have to be updated with function to handle the new operation, but
the constructor doesn't have to be updated. It can simply be added to with a "put" to add the new
operation.

Message-passing style is similar to data-directed, but instead of an entire table, you only need one
column of the table. Each column is compressed into a function that takes in arguments of a given type
(ie "magnitude" and "angle") and outputs a function that takes in an operation. Depending on the
operation, a function definition is chosen. To add new types, we must make a new selection function, ie
"make-from-r-theta-phi").

To me, the easiest system to work in when frequently adding new types is message-passing. A new
selection, independent of the existing selection function, is all that is needed. To add a new operation,
we have to add one line for for the operation in each of the selection functions. However, since this 
line is in the constructor of selection function, someone would argue that it's more troublesome than
using the "put" function with the data-driven function. I like the self contained nature of the
message-passing style, but some might like the ease of adding new operations in the data-directed style.
|#