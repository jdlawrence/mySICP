#lang sicp
(define (square n)
  (* n n))
  
(define (expmod base exp m)
  (define (square-checker base n)
  (if 
    (and (not (= base 1))
         (not (= base (- n 1)))
         (= (remainder (square base) n) 1))
    0
    (remainder (square (expmod base (/ exp 2) m))
                    m)))
  (cond
        ((= exp 0) 1)
        ((even? exp) (square-checker base m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (miller-rabin n)
  (define (try-it a)
     (= (expmod a (- n 1) n) 1))
  (try-it (+ 2 (random (- n 2)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((miller-rabin n) (fast-prime? n (- times 1)))
        (else false)))

;(miller-rabin 9)
(fast-prime? 561 100)
