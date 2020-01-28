#lang racket

#|
Find a circular list using a constant amount of space:

I've seen this before and will not take the time the time figure it out,
but it goes something like this.

Have two counters, one fast, and one slow. The fast counter moves forward
two nodes at time, or in Racket's case, the "caddr" of the list. The slow
counter moves one node at time, or in Racket's case, the "cadr" of the list
For example, given a list, '(a b c d e), the faster counter would jump to 'c,
and the slow counter would jump to 'b. If at any time, the "cadr" or "caddr"
is the empty list, we have reached the end of the list and it's not a cycle.
However in the case of a cycle, the fast counter and slow counter will
eventually be the same node. We check for equality between the fast and slow
nodes, and if they're equal, we return true for the function. 
|# 

#| Testing |#
(define aList '(a b c d))
(car (cdr (cdr aList)))
(caddr aList)

