#lang racket

(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

(accumulate + 0 (list 1 2 3 4 5))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)
                          ))))

#| Just for my own practice |#
(define (map-j op items)
  (if (null? items)
      '()
      (cons (op (car items)) (map-j op (cdr items)))))

#| Testing |#
(define ex (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))

(map car ex)
(map-j car ex)
(accumulate-n + 0 ex)

