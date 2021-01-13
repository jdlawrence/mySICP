#lang sicp

#| Answer:
Consider the following functions:

|#
(define (g x) (+ x 1)) 
(define (f g x) (g x))

#| g(x) is a procedure, which needs to be an actual value, and not a thunk to call. If
we don't use force-it, g will be passed a thunk to apply, which apply is not equipped to
handle. We need it passed as a procedure and not a thunk.
|#