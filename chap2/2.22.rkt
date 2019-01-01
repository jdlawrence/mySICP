#lang racket
(define (square x)
  (* x x))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list (cdr items)))))

(define (square-list-m items)
  (map (lambda (x) (* x x)) items))

(define (reverse aList)
  (if (null? aList)
      '()
      (append (reverse (cdr aList)) (list (car aList)) )))

(define (square-list-r items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items '()))

(define (square-list-r-correct items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (append answer (list (square (car things)))))))
  (iter items '()))
#| Testing |#
;(square-list (list 1 2 3 4 5 6))
;(square-list-m (list 1 2 3 4 5 6))
(square-list-r (list 1 2))

#|
*** Answer ***

The first approach (square-list-r) doesn't work and results in a reversed squared list. This is
because we are moving through the list and using cons to put together the current value and the
squared (and reversed) prior values in the list. Looking at the definition of "reverse" above,
this is exactly the procedure that was used. So it results in a reversed list, which we can fix
by either reversing the given list, or reversing the answer.

Second Approach:
When you try to switch the arguements to cons, putting the answer first and then the squared value,
you pass cons a list as the first argument, which Racket stores as a value. This creates a nested
list as the first argument and then a plain value as the second argument. "Cons" needs a value as its
first argument and a list or empty list as its second argument. To make this work correctly, we can
use "append". "Append" expects two lists as its arguments, so we must surround "(square (car things))"
with a list:

(append answer (list (square (car things))))
|#
