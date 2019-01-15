#lang racket
(define nil '())

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

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence) (accumulate op initial (cdr sequence)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (even-fibs2 n)
  (accumulate cons
              '()
              (filter even?
                      (map fib
                           (enumerate-interval 0 n)))))
(even-fibs2 30)

(define (map2 p sequence)
  (accumulate (lambda (x y) (p x)) nil sequence))

(define (square x) (* x x))

(map2 square (enumerate-interval 0 5))

(define (mapJ transducer aList)
  (if (null? aList)
      '()
      (cons (transducer (car aList)) (map transducer (cdr aList)))))
  
(mapJ (lambda (x) (* x 2)) (list 1 2 3 4))



