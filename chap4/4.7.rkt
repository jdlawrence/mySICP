#lang racket

#| Given from other exercises |#
(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define example '(let* (
                        (x 3)
                        (y (+ x 2))
                        (z (+ x y 5))
                        )
                   (* x z)))

#| The expression above could be written as:
(let
    ((x 3))
  (let
      ((y (+ x 2)))
    (let
        ((z (+ x y 5)))
      (* x z)
      )))
|#


#| Answer: |#
(define (let*-body exp) (caddr exp))
(define (let*-assignments exp) (cadr exp))

(define (let*->nested-let aLetExp)
  ; For each expression in aLetExp, nest another
  ; '(let (', the expression, and ')
  (let (
        (body (let*-body aLetExp))
        (assignments (let*-assignments aLetExp))
        )
    (define (make-let exp body)
      (if (null? exp)
          body
          (list 'let (list (car exp))
          (make-let (cdr exp) body))))
    (make-let assignments body)))

#|
If we have already implemented let (Exercise 4.6) and we
want to extend the evaluator to handle let*, IT IS sufficient
to add a clause to eval whose action is (eval (let*->nested-lets exp) env)
|#

#| Testing |#



(let ((x 3))
  (let ((y (+ x 2)))
    (let ((z (+ x y 5)))
      (* x z))))

(let*->nested-let example)

(let ((x 5))
  (+ x 10))

(define x 5)
