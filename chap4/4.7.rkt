#lang racket
(let* (
       (x 3)
       (y (+ x 2))
       (z (+ x y 5))
       )
  (* x z))

#| The expression above could be written as: |#

(let ((x 3))
  (let ((y (+ x 2)))
    (let ((z (+ x y 5)))
      (* x z))))

#| Answer: |#
(define (let*->nested-let aLetExp)
  ; For each expression in aLetExp, nest another
  ; '(let (', the expression, and ')
  (if (null? aLetExp)
      '()
      (cons
        (eval '(let (cons (car aLetExp))) env)
        (let*->nested-let (cdr aLetExp)))))
#| Testing |#
(let ((x 5))
  (+ x 10))

(define x 5)

(define (no)
  (+ x 10))

(no)