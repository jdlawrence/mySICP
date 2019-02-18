#lang racket
(define (fold-right op initial items)
  (if (null? items)
      initial
      (op (car items) (fold-right op initial (cdr items)))))

(define (fold-left op initial items)
  (define (sub result elements)
    (if (null? elements)
        result
        (sub (op result (car elements)) (cdr elements))))
  (sub initial items))

(define (reverse-l sequence)
  (fold-left (lambda (x y) (cons y x)) '() sequence))

(define (reverse-r sequence)
  (fold-right (lambda (x y) (append y (list x))) '() sequence))

(define ex (list 1 2 3))

(define (append-j list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append-j (cdr list1) list2))))

#| Just for recollection |#
(define (reverse-j a-list)
  (define (sub items result)
    (if (null? items)
        result
        (sub (cdr items) (append (list (car items)) result))))
  (sub a-list '()))

;(append-j (list 1 2 3) (list 4 5 6))  
#| Answers |#
(reverse-j (list 3 5 7 9))
(reverse-l ex)
(reverse-r ex)
