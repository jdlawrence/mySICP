#lang racket
(define example '(let* (
                        (x 3)
                        (y (+ x 2))
                        (z (+ x y 5))
                        )
                   (* x z)))

#| The expression above could be written as: |#

(define (let*-body exp) (caddr exp))
(define (let*-assignments exp) (cadr exp))

(let ((x 3))
  (let ((y (+ x 2)))
    (let ((z (+ x y 5)))
      (* x z))))

#| Answer: |#


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

;((let (x 3)) (let (y (+ x 2))) (let (z (+ x y 5))) * x z)

#|
'(let ((x 3)) (let ((y (+ x 2))) (let ((z (+ x y 5))) (* x z))))
'(let (x 3) (let (y (+ x 2)) (let (z (+ x y 5)) (* x z))))

(let
    ((x 3))
  (let
      ((y (+ x 2)))
    (let
        ((z (+ x y 5)))
      (* x z)
      )))
|#
#| Testing |#

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

#|
(define (let*? expr) (tagged-list? expr 'let*)) 
(define (let*-body expr) (caddr expr)) 
(define (let*-inits expr) (cadr expr)) 
(define (let*->nested-let expr) 
  (let ((inits (let*-inits expr)) 
        (body (let*-body expr))) 
    (define (make-lets exprs) 
      (if (null? exprs) 
          body 
          (list 'let (list (car exprs)) (make-lets (cdr exprs))))) 
    (make-lets inits)))
|#

(let*->nested-let example)

(let ((x 5))
  (+ x 10))

(define x 5)

(define (no)
  (+ x 10))

(no)