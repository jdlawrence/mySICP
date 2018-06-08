#lang sicp
(define (square n)
  (* n n))

(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (alyssa base exp m)
  (remainder (fast-expt base exp) m))

;(expmod 2 7 5)
;(alyssa 2 7 5)
;(random 5)

(define (fermat-test n)
  (define (try-it a)
    ;(= (expmod a n n) a))
    (= (alyssa a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (next n)
  (if (= n 2)
      3
      (+ n 2)))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        ;(else (find-divisor n (+ test-divisor 1)))))
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  ;(newline)
  ;(display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  ;(if (prime? n)
  (if (fast-prime? n 10)
      (report-prime (- (runtime) start-time) n)
      #f))

(define (report-prime elapsed-time prime)
  (display prime)
  (display " *** ")
  (display elapsed-time)
  (newline))

;(prime? 19)
(timed-prime-test 1319)

