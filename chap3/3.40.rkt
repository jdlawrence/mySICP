#lang sicp
(define x 10)

(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))

#| Part A:
100       : P1 accesses x (twice), P2 sets x to 1000, then P1 sets x
1000      : P2 accesses x (thrice), P2 sets x to 100, then P2 sets x
10,000    : P2 accesses x twice as 10, P1 sets x to 100, and P2 accesses x a final time as 100
10,000    : P1 accesses x as 10, P2 sets x to 1000, P1 accesses it's second x as 1000
100,000   : P2 accesses x once, P1 sets x to 100, then P2 access x twice more as 100
1,000,000 : P1 then P2, or P2 then P1

Part B:

If we serialize these procedures, only 1,000,000 remains

|#



