#lang racket
(define (square n) (* n n))
(define nil '())
(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(accumulate
 append '() (map (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1)))) ; Generates a list 1 ...(i - 1)
                 (enumerate-interval 1 5)))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(flatmap (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1)))) (enumerate-interval 1 5))



(define (smallest-divisor n) (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b) (= (remainder b a) 0))

(define (prime? n)
(= n (smallest-divisor n)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

#| Answers
Just use the already provided definition of flatmap with two loops
that enumerate from 1 to n and from 1 to (i - 1)
To simplify flatmap, use unique-pairs to substitute for the flat map that would
generate all of the pairs.
|#
(define (unique-pairs n)
  (flatmap (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 n)))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum? (flatmap
                           (lambda (i)
                             (map (lambda (j) (list i j))
                                  (enumerate-interval 1 (- i 1))))
                           (enumerate-interval 1 n)))))

(define (prime-sum-pairs-simple n)
  (map make-pair-sum
       (filter prime-sum? (unique-pairs n))))

#| Testing |#
(unique-pairs 6)
(prime-sum-pairs 6)
(prime-sum-pairs-simple 6)