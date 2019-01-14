#lang racket
#| For practice |#
(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter b (+ a b) (- count 1))))
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (fib-iter 0 1 n)))) 

(fib 7)

(define (even-fibs n)
  (define (next k)
    (if (> k n)
        '()
        (let ((f (fib k)))
          (if (even? f)
              (cons f (next (+ k 1)))
              (next (+ k 1))))))
  (next 0))

(even-fibs 30)