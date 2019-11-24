#lang sicp

(define (last-pair x)
  (if (null? (cdr x)) x (last-pair (cdr x))))

(define (append! x y)
  (set-cdr! (last-pair x) y)
  #| Experimenting with using cons instead of set-cdr! 
  ;(cons (last-pair x) y)
|#
  x)

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))


#| Answers: |#
(cdr x); (list 'b)

(define w (append! x y))

(cdr x); (list 'b 'c 'd)


