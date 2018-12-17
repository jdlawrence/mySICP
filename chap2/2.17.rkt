#lang racket

(define (last-pair aList)
  (define (sub subList val)
    (if (null? subList)
        (list val)
        (sub (cdr subList) (car subList))))
  (sub aList (car aList)))

#| Alternate version doesn't need a carry along variable
and also won't fail for an empty list |#
(define (last-pair-alt aList)
  (define (sub nonEmptyList)
    (if (null? (cdr nonEmptyList))
      (list (car nonEmptyList))
      (last-pair-alt (cdr nonEmptyList))))
  (if (null? aList)
      aList
      (sub aList)))

#| Testing |#
(define jamil (list 1 2 3 4))

(last-pair jamil)

(last-pair (list 23 72 149 34))

(last-pair-alt (list 23 72 149 34))

(define emptyList (cdr (list 1)))

(last-pair-alt emptyList)



