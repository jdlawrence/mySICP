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

(define (map-my-version p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(map-my-version (lambda (x) (* x x)) (list 1 2 3 4 5))

#| Testing |#
(accumulate + 0 (list 1 2 3 4 5))
(map fib (enumerate-interval 0 6))
(fib 1)          
(fib 2)          
(fib 3)          