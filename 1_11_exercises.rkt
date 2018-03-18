#lang sicp

(define (count-change amount)
  (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

;(count-change 100)

; Recursive Version
(define (f-r n)
  (cond ((< n 3) n)
        (else (+ (f-r (- n 1))
                 (* 2 (f-r (- n 2)))
                 (* 3 (f-r (- n 3)))))))
;(f-r 8)

; Iterative Version
#|
For the iterative version, we can start by realizing:
f(0) = 0
f(1) = 1
f(2) = 2
So the question is f(3).
f(3) = f(2) + 2f(1) + 3f(0). We already have the values for
n = 0, 1, and 2, so this is a calculation we can do.
Let a = f(n)
    b = f(n-1)
    c = f(n-2)
The iterative process is counting up until we have reached n.
With each iteration, we substitute for the values of a,b, and c
as described below:
b from the previous iteration becomes c 
a from the previous iteration becomes b 
a is redefined as the previous a plus 2 times previous b plus 3 times previous c

In symbols:
b -> c
a -> b
a + 2b + 3c -> a

|#
(define (f-it n)
  (define (sub a b c count)
    (if (= count n)
        a
        (sub (+ a (* 2 b) (* 3 c)) a b (+ count 1)))) 
  (if (< n 3)
      n
      (sub 2 1 0 2)))

(f-it 2)
(f-it 3)
(f-it 4)
(f-it 5)
(f-it 6)
(f-it 7)

