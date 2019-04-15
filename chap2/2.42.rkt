#lang racket
#|
(list 
(list '() '() '())
(list '() '() '())
(list '() '() '())
)
|#

(define (accumulate proc init items)
  (if (null? items)
      init
      (proc (car items) (accumulate proc init (cdr items)))))

(define (map-j proc seq)
  (if (null? seq)
      seq
      (cons (proc (car seq)) (map-j proc (cdr seq)))))

;(append (list 4 5 6) (list 1 2 3))

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

(define (create-board n)
  (map (lambda (x) (create-row n)) (enumerate-interval 1 n)))

;(create-board 6)

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

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


;NOTE: the index is 1-based and not 0 based
(define (change-list-val val index aList)
  (define (sub curr currList result)
    (if (= curr index)
        (append result (list val) (cdr currList))
        (sub (+ curr 1) (cdr currList) (append result (list (car currList))))))
  (sub 1 aList (list)))

;(change-list-val 8 5 (list 1 2 3 4 5))

;NOTE: both row and column are 1-based and not 0-based
(define (adjoin-position row col board)
  (define (sub rowIndex currentBoard result)
    (if (= rowIndex row)
        (append result (list (change-list-val 1 col (car currentBoard))) (cdr currentBoard))
        (sub (+ rowIndex 1) (cdr currentBoard) (append result (list (car currentBoard))) )))
  (sub 1 board (list)))

;(adjoin-position 3 3 (list (list 0 0 0) (list 0 0 0) (list 0 0 0)))

(define rest-of-queens (list (list 0 0 1 0) (list 1 0 0 0) (list 0 0 0 0) (list 0 1 0 0)) )
(define k 4)
(define board-size 4)

rest-of-queens
(map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size))

;WORK ON THIS
(list-ref (list 1 2 3 4 5 6 7) 3)

          
(define (get-col board col)
  (define (sub result rest)
    (if (null? rest)
        result
        (sub (append result (list (list-ref (car rest) (- col 1)))) (cdr rest))))
  (sub (list) board))

(get-col rest-of-queens 1)
    
;(define (safe col list-of-boards))
;   (
