#lang racket
(define ns (make-base-namespace))

#| Answer |#
(define (eval-and exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        ((true? (first-exp? exps)) (eval-and (cdr exps) env))
        (else false)
         ))

(define (eval-or exps env)
  (cond ((last-exp? exps) (eval (first-exp exps) env))
        (true? (eval (first-exp exp) env))
        (else
         (eval-or (cdr exps) env))))

#| The alternative definition uses derived expressions, basically working "if" |#

(define (eval exp env)
  (cond ((self-evaluating? exp) exp)
        ((variable? exp) (lookup-variable-value exp env))
        ((quoted? exp) (text-of-quotation exp))
        ((assignment? exp) (eval-assignment exp env))
        ((definition? exp) (eval-definition exp env))
        ((if? exp) (eval-if exp env))
        ((and? exp) (eval-and exp env))
        ((or? exp) (eval-or exp env))
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
