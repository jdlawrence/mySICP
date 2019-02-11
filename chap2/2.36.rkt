#lang racket

(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

(accumulate + 0 (list 1 2 3 4 5))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (car (car seqs)))
            (accumulate-n op init (cdr seqs)
                          ))))

(define ex (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

(accumulate-n + 0 ex)

