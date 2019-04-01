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
        (sub (+ length-so-far 1) (append result (list '()) ))))
  (sub 0 (list)))

(length (list ))
(create-row 3)
#|
(define (create-board n)
  (define (sub rows-so-far result)
    (if (= rows-so-far n)
        result
        (sub (+ rows-so-far 1) (append result (create-row n)))))
  (sub 0 (list)))
|#

;(map (lambda (x) (create-row 3)) (list 1 2 3 4))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(enumerate-interval 1 4)
(define (create-board n)
  (map (lambda (x) (create-row n)) (enumerate-interval 1 n)))

(create-board 3)

(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

;(flatmap (lambda (x) (* x x)) (list 1 2 3 4))

(flatmap (lambda (i)
       (map (lambda (j) (list i j))
            (enumerate-interval 1 (- i 1))))
     (enumerate-interval 1 4))

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

;WORK ON THIS!
(map (lambda (new-row)
                   (adjoin-position
                    new-row k rest-of-queens))
                 (enumerate-interval 1 board-size))