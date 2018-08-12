#lang sicp
#|
To figure out p' and q':
We can use a or b, but b is simpler.

b <- bp + aq

Plug in the expressions for a and b into the expression
for the next b:
Since a = bq + aq + ap and b = bp + aq,
b <- (bp + aq)p + (bq + aq + ap)q

Simplification:
bpp + apq + bqq  + aqq + apq

Combine like terms:
bpp + bqq + 2apq + aqq

Factor out a and b:
b(pp + qq) + a(2pq + qq)
b(p^2 + q^2) + a(2pq + q^2)

This means:
p' = p^2 + q^2
q' = 2pq + q^2
|#
(define (square x) (* x x))
(define (fib n)
  (fib-iter 1 0 0 1 n))

(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (square p) (square q))     ; compute p'
                   (+ (* 2 p q) (square q))      ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(fib 0)
(fib 1)
(fib 2)
(fib 6)
(fib 7)
