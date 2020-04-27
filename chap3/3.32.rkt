#lang sicp
(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value
           (logical-and (get-signal a1) (get-signal a2))))
      (after-delay
       and-gate-delay
       (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

#|
In the and-gate, it's a fixed condition that add-action for a1 comes before
add-action for a2 because that's the way the code is written. a1's action
is first in, and in a queue it would be first out. So let's say we start with the
values specified in the exercise, (a1, a2) = (0, 1). We want to get to a new state
of (a1, a2) = (1, 0), but we take a couple of intermediate steps to get there,
evaluating logical-and at each step, and taking the final result of the last
logical-and as the final result at that time. KEY POINT: At each step, the wires keep
their original values, not the carried values from the previous step.

Using a Queue (FIFO):
Step 0: (a1, a2) = (0,1) Output of logical-and: 0.
Step 1: a1 -> 1. (a1, a2) = (1, 1) Output: 1
Step 2: a2 -> 0. (a1, a2) = (0, 0) Output: 0

The last step outputted 0, so the final answer is 0.

Using a List (LIFO, like a stack):
Step 0: (a1, a2) = (0,1) Output of logical-and: 0.
Step 1: a2 -> 0. (a1, a2) = (0, 0) Output: 0
Step 2: a1 -> 1. (a1, a2) = (1, 1) Output: 1

The last step outputted 1, so the final answer is 1.

This is why it's important to use FIFO logic in the storage of a segment's procedures.
|#


            

