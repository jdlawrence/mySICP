#lang sicp

#| Answer Part a):

Ben is right because the for-each print the value of each expressions as expected.

|#

#| Part b):
In Cy's version of eval-sequence, both (p1 1) and (p2 1) return (1 2). However with
ther original version, (p2 1) returns just 1, and not a list containing (1 2). This is
because we're returning a thunk and not the actual value.

|#

#| Part c):
In the for-each from part a, we're return only primitive values and not procedures, so
it does not matter which version of eval-sequence we use.
|#

#| Part d):
I like Cy's version better. I tested with standard Racket language and it's consistent
with Cy's.
|#

#| Testing |#


;(list 57 321 88))
;(for-each (lambda (x) (newline) (display (* x 3)))
;          (cons (+ 1 2) (cons (+ 2 3) (cons (+ 3 4) '()))))
;(cons 57 (cons 321 (cons 88 '()))))

(define (p1 x)
  (set! x (cons x '(2)))
  x)

(define (p2 x)
  (define (p e)
    e
    x)
  (p (set! x (cons x '(2)))))


(p1 1)
(p2 1)