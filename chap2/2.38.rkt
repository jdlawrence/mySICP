#lang racket
#| Because accumulate doesn't return a value until it's recursively
called all the way the rightmost item in the list, we're working from
right to left. We start by applying the op to the initial and the rightmost
item, then taking that and applying it to the second rightmost item, then taking
 that and applying it to third rightmost item, etc. Hence the alias for accumulate,
fold-right. |#
(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

#| Fold left works in the opposite direction: we start by combining the initial and
the leftmost item, then taking that result and combining it with the second
leftmost, then the third leftmost, etc. |#
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(accumulate * 1 (list 1 2 3 4))
(fold-left * 1 (list 1 2 3 4))

#| Answers |#
(list (list '() 1) 2)
(accumulate / 1 (list 1 2 3)) ; 3/2
(fold-left / 1 (list 1 2 3)) ; 1/6
(accumulate list '() (list 1 2 3)) ; (list 1 (list 2 (list 3 () )))
(fold-left list '() (list 1 2 3)) ; (list (list (list () 1) 2) 3)
#| If a property is commumative (order does not matter), then it doesn't
matter whether we use fold-left or fold-right |#