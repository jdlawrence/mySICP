#lang sicp
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
 (lambda (f) (lambda (x) (f ((n f) x) ))))

(define xVal 0)

(define (fEx x) (+ x 2))

((zero fEx) xVal) ;returns 0

(((add-1 zero) fEx) xVal) ; return 2

(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x) )))
(lambda (f) (lambda (x) (f x) ))
(f x)

(add-1 one)
(lambda (f) (lambda (x) (f ((one f) x) )))
(lambda (f) (lambda (x) (f (f x)) ))
(f (f x))

#|
one is (f x)
two is (f (f x))

+, meaning addition, is f (m + n) number of times
For ex, if m is three, and n is four, three + four is
(f (f (f (f (f (f (f x)))))))
|#


