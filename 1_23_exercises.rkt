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

;(expmod 3 4 5)
;(random 5)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;(fast-prime? 15 1) ;15 is not prime, but since we're only trying once, this has a chance of being true;


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
  (if (prime? n)
      (report-prime (- (runtime) start-time) n)
      #f))

(define (report-prime elapsed-time prime)
  (display prime)
  (display " *** ")
  (display elapsed-time)
  (newline))

;(prime? 19)
;(timed-prime-test 131)

(define (search-for-primes current end)
  ;(display current)
  ;(display "\n")
  (timed-prime-test current)
  (if (< current end)
      (search-for-primes (+ current 2) end)))

(search-for-primes 999999 1000100)

;(next 2)
;(next 3)
;(next 4)
;(next 5)


#|
When we use the next procedure, we are halving the number the amount of numbers
we have to test to see if a number is prime. However since the time complexity of this function is
O(sqrt(n)), we see our times drop by sqrt(2) ~= 1.414.
|#