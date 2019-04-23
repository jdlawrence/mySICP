#lang racket
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

#| Louis's code:
|#

(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))
#| Answer:

Louis's answer calls queen-cols board-size times. Since queens-col is the
outer procedure and it's called recursively, it calls another queen-cols board-size
times. For example, the first call to enumerate-interval board size calls 1 2 3 4.
Each of these calls queen-cols (n-1) times.
1 -> 3, 2, 1
2 -> 3, 2, 1
3 -> 3, 2, 1
4 -> 3, 2, 1

Therefore the time complexity is O(T*T).
#|