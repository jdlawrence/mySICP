#lang racket
(define x (list 1 2 3))
(define y (list 4 5 6))

#| Answer |#
(append x y) ; '(1 2 3 4 5 6), puts the first list after the second. Final result is
; a list 6 items long.

(cons x y) ; '((list 1 2 3) 4 5 6) puts the first list as a single value in the pair
; and spreads the second list as values for the rest of the list. Basically a list 4
; items long

(list x y) ; '((1 2 3) (4 5 6)) puts the first list as the first value in a list, and
; the second list values the second value in a list. Basically a list 2 items long


