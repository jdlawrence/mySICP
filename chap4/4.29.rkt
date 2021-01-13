#lang sicp

#| Answer:
I'd expect a fibonacci program to run much slower without with memoization than with it.
I confirmed this with my fibonacci program below:
(fibo 30) -> memoized -> 21.97s
(fibo 30) -> not memoized -> 170.97s

BIG DIFFERENCE!

|#

(define (fibo x)
  (cond ((= x 0) 1)
        ((= x 1) 1)
        (else (+ (fibo (- x 1)) (fibo (- x 2))))))

#| Answer, part 2

Let count be 0:

(define count O)

Define id as given before:

(define (id x) (set! count (+ count 1)) x)

For the function and invocation:

(define (square x) (* x x))
(square (id 10))

I saw no differences in the memoized and unmemoized outputs for "count". It still increments by 1 every time.
|#
#| Testing |#
(fibo 30)