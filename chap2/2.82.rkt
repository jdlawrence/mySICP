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
;(define (coerce-all a-list type)
;  (if (