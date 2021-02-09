#lang sicp

#|
Define rules to implement the last-pair
operation of Exercise 2.17, which returns a list containing
the last element of a nonempty list. Check your rules on
queries such as (last-pair (3) ?x), (last-pair (1 2
3) ?x) and (last-pair (2 ?x) (3)). Do your rules work
correctly on queries such as (last-pair ?x (3)) ?
|#

; The last-pair of a list containing a single item is a list containing that item
(rule (last-pair (?x) (?x)))

; If the ?last symbol is equal to a list contain ?x, then ?last symbol as a
; cdr in a list is equal to ?x
(rule (last-pair (?anything . ?last) (?x))
           (last-pair ?last (?x)))

; The query below goes into an infinite loop and does not complete
(last-pair ?x (3)) 