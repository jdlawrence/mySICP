#lang sicp

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))


(define x (list 'a 'b 'c))


(define (make-cycle x)
(set-cdr! (last-pair x) x)
x)

(define j (make-cycle (list 'a 'b 'c)))

#| Answer |#
;Will result in an infinite loop because j is a circular list
(last-pair j)

