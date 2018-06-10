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
         (remainder (* (expmod2 base (/ exp 2) m) (expmod2 base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod2 base (- exp 1) m))
                    m))))
;(expmod 2 3 5)
(expmod2 2 3 5)

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

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
;(timed-prime-test 1319)

#|
Let's look at Louis Reasoner's definition of expmod. It uses:
 (* (expmod base (/ exp 2) m) (expmod base (/ exp 2) m))

Due to the fact that Scheme (and Racket) are Applicative-order evaluation, we must breakdown the arguments
provided to * first into primitives, and each case of (expmod base (/ exp 2) m) will be evaluated
indepenently.

If we had used:

(square (expmod base (/ exp 2) m)), we only have to evaluate (expmod base (/ exp 2) m) once. Therefore it
will be MUCH faster.

Since we are doubling the number of expmod calls for each recursive call, we are actually calling this
exponentially more times. Our original time complexity for this function was O(log n). Since we are now
calling n an exponential number of times, we can substitute 2^n for n, and we now get O(log(2^n)). This
simplifies to O(n).
|#
