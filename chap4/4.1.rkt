#lang racket
(define ns (make-base-namespace))

#| Given |#
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (eval (first-operand exps) env)
            (list-of-values (rest-operands exps) env))))


#| Accepted answer from others. Note that this includes the use of a nested let. I debugged and didn't find it necessary,
but maybe it is?

|#
(define (list-of-values-rl exps env) 
   (if (no-operands? exps) 
       '() 
       (let ((right (list-of-values-rl (rest-operands exps) env))) 
         (let ((left (eval (first-operand exps) env)))
           (cons left right)))))

#| My answer without the nested "let". When I placed the debugger at the eval function call, it was in called in right to left
order, so I believe it works, but other solutions require the nested let.
|#

(define (list-of-values-rl2 exps env) 
   (if (no-operands? exps) 
       '() 
       (let (
             (left (eval (first-operand exps) env))
             (right (list-of-values-rl-2 (rest-operands exps) env)) 
            )
           (cons left right))))           

(list-of-values '(+ 1 2 3) ns)
(list-of-values-rl '(+ 1 2 3) ns)
(list-of-values-rl2 '(+ 1 2 3) ns)
(eval '(+ 2 3) ns)

