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

;(expmod 2 3 3)
;(expmod 5 6 6)

(define (print-failure n)
  (display "This number fails the Fermat test for ")
  (display n)
  (newline)
  )

(define (print-success n)
 (display n)
 (display " passes the Fermat for all integers less than itself.")
 (newline))

(define (carmichael-test n)
  (define (carmichael-countdown n current)
    (cond ((= current 0) (print-success n))
          ((= (expmod current n n) current)
              (carmichael-countdown n (- current 1)))
          (else 
             (print-failure current))))
  (carmichael-countdown n (- n 1)))

(carmichael-test 561)
(carmichael-test 1105)
(carmichael-test 1729)
(carmichael-test 2465)
(carmichael-test 2821)
(carmichael-test 6601)

