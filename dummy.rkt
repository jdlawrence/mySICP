#lang sicp

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

;(define abc (list 'a 'b 'c))
(define abc '(a b c))
(define def (cons 'd (cons 'e (cons 'f '()))))
;(define z (make-cycle abc))

;(cons 'a (cons 'b (cons 'c '())))
;(list 'a 'b 'c)
(memq 'a abc)
(memq 'd def)
(memq 'h def)
;(define (cycle? a-list)
  




