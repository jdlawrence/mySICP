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

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((lambda? exp) (make-procedure (lambda-parameters exp)
                                       (lambda-body exp)
                                       env))
        ((begin? exp)
         (eval-sequence (begin-actions exp) env))
        ((cond? exp) (eval (cond->if exp) env))
        ((application? exp)
         (apply (eval (operator exp) env)
                (list-of-values (operands exp) env)))
        (else
         (error "Unknown expression type: EVAL" exp))))

#| Answer, part A:
If the procedure appliations in the eval definition are moved before the assignment clause,
an expression like (define x 3) will try to evaluate the "x" as a procedure instead of a variable.

Answer: part B:
We were given these definitions:
(define (application? exp) (pair? exp))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

First, we just have to let the evaluator know that "application?" begins with 'call: |#
(define (application? exp) (tagged-list? exp 'call))

#| Then, since we have the extra "call" we just have to change the definition for operator and operands to use the
2nd and 3rd elements in the pair, instead of the 1st and second: |#
(define (operator exp) (cadr exp))
(define (operands exp) (cddr exp))
|#

