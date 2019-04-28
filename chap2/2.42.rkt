#lang racket
(define (accumulate proc init items)
  (if (null? items)
      init
      (proc (car items) (accumulate proc init (cdr items)))))

(define (create-row length)
  (define (sub length-so-far result)
    (if (= length-so-far length)
        result
        (sub (+ length-so-far 1) (append result (list 0) ))))
  (sub 0 (list)))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (adjoin-position row col other-queens)
  (define (sub rowIndex result)
    (if (> rowIndex row)
        result
        (sub (+ rowIndex 1) (append other-queens (list (list rowIndex col))))))
  (sub 1 (list)))

;(define rest-of-queens (list (list 2 1) (list 4 2) (list 1 3)))
;rest-of-queens
;(adjoin-position 3 3 rest-of-queens)
(define k 4)
(define board-size 4)

(define (get-rows queens)
  (define (sub result rest)
    (if (null? rest)
        result
        (sub (append result (list (car (car rest)))) (cdr rest))))
  (sub (list) queens))

(define (safe-row col positions)
  (define (sub index queen-list new-queen )
    (if (< index col)
        (if (= (car queen-list) new-queen)
          #f
          (sub (+ index 1) (cdr queen-list) new-queen))
        #t))
  (sub 1 (get-rows positions) (car (list-ref positions (- col 1)))))

(define (slope q1 q2)
  (let ((x1 (first q1))
        (x2 (first q2))
        (y1 (second q1))
        (y2 (second q2)))
    (if (= x2 x1)
        +nan.0
        (/ (- y2 y1) (- x2 x1)))))

(define (safe-diag col positions)
  (define (sub index queen-list new-queen)
    (if (< index col)
        (if ( = 1 (abs (slope (car queen-list) new-queen)))
            #f
            (sub (+ index 1) (cdr queen-list) new-queen))
        #t))
  (sub 1 positions (list-ref positions (- col 1))))

#| More Testing 
(define sample-board (list (list 2 1) (list 4 2) (list 1 3) (list 2 2)))
(safe-diag 4 sample-board)
|#

(define (safe? k positions)
  (and (safe-row k positions)
       (safe-diag k positions)))

(define empty-board (list))
#|
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
|#
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (flatmap
         (lambda (rest-of-queens)
           (map (lambda (new-row)
                  (adjoin-position
                   new-row k rest-of-queens))
                (enumerate-interval 1 board-size)))
         (queen-cols (- k 1)))))
  (queen-cols board-size))

(define (queens2 board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (queen-cols (- k 1))
                 
                 ))
          (enumerate-interval 1 board-size)
          )))
  (queen-cols board-size))
(queens 2)
;(queens2 2)
;(length (queens 5))
;(length (queens 6))
;(length (queens 7))
;(length (queens 8))

