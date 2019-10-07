#lang racket
#| Answer:

"One strategy is to aempt to coerce all the arguments to the type of the first argument,
then to the type of the second argument, and so on. Give an example of a situation where
this strategy (and likewise the two-argument version given above) is not sufficiently general."

If you have mixed types that don't coerce to one another, this strategy won't work. For
example, for if one type is a triangle and the other is square, they can never be coerced into
each other.

The crux of this problem is getting the type of the first, and trying to coerce all types to that
of the first. Then get the type of the second, then try to coerce all types to that of the second,
etc. Basically map with get-type, all iterate over results to see for any of the items in the map,
can we coerce all types.


|#
(append (list 1 2 3) (list 4 5 6))

#| Run a test for every time
Run a test for every element in a list
Return true if every element passes or false otherwise
|#

(define (every elements test)
  (cond ((null? elements) #t)
        ((not (test (car elements))) #f)
        (else (every (cdr elements) test))))

(define (some elements test)
  (cond ((null? elements) #t)
        ((test (car elements)) #t)
        (else (every (cdr elements) test))))

(define (coerce-all a-type elements)
  (if (every elements (lambda (element) (get-coercion a-type (type-tag element))))
      
#| Testing |#
(define (greater-than-zero x)
  (> x 0))

(every (list -11 2 3) greater-than-zero)
(some (list -11 -22 -23) greater-than-zero)