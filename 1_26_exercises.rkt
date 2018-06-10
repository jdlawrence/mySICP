#lang sicp
(define (square n)
  (* n n))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (expmod2 base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (* (expmod base (/ exp 2) m) (expmod base (/ exp 3) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))
(expmod 2 7 5)
(expmod 2 7 5)


