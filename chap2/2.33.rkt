#lang racket
(define (accumulate op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (accumulate op initial (cdr sequence)))))


(define (fib n)
  (define (sub curr prior count)
    (cond ((= n 0) 0)
          ((= n 1) 1)
          ((= n count) curr)
          (else (sub (+ curr prior) curr (+ count 1)))))
  (sub 1 0 2))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

#| p is your transformer function, like square or double |#
(define (map-my-version p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

#| Since we are using con, which appends to the front of a list,
we start with seq2 and gradually tack on values from seq1, starting
with the last value and moving from right to left|#
(define (append-my-version seq1 seq2)
  (accumulate cons seq2 seq1))

(define (add-one-to-y x y) (+ y 1))
(define (length-my-version sequence)
  (accumulate add-one-to-y 0 sequence))

#| Testing |#
(map-my-version (lambda (x) (* x x)) (list 1 2 3 4 5))
(append-my-version (list 1 2 3) (list 4 5 6))
(length-my-version (list 1 2 3 4)) 
(accumulate + 0 (list 1 2 3 4 5))
(map fib (enumerate-interval 0 16))
(fib 13)          