#lang racket
(define a
  (lambda (ft k)
    (if (= k 1)
        1
        (* k (ft ft (- k 1)))
        )
    )) 

((lambda (n)
   ((lambda (fact) (fact fact n))
    a))
 3)

#| Answer:
a)
This does work. I changed the procedure a bit to call inner most lambda "a" so that I could see what was going on.
The lambda-n calls a function with an argument of 3 that returns lambda-fact. Lambda-fact returns a function that
takes in a function, a, and calls (fact fact 3), which ends up being (a a 3). (a a 3) is evaluated, and it returns:

(* k (ft ft (- k 1))).

In our case this is:

(* 3 (a a 2))

(a a 2) returns (* 2 (a a 1))

(a a 1) returns 1.

|#

; Fibonacci:

((lambda (n)
   ((lambda (fact) (fact fact n))
    (lambda (ft k)
      (cond ((= k 1) 1)
            ((= k 0) 1)
            (else
             (+ (ft ft (- k 1)) (ft ft (- k 2))))))))
 10)

#| Answer, b) |#

#| Given example, which uses internal defines:

(define (f x)
  (define (even? n)
    (if (= n 0) true (odd? (- n 1))))
  (define (odd? n)
    (if (= n 0) false (even? (- n 1))))
  (even? x))
|#

(define (f x)
  ((lambda (even? odd?) (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) true (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) false (ev? ev? od? (- n 1))))
   ))

(f 1)
