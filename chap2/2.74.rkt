#lang racket

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((get (operator exp) 'deriv) (operands exp) var)
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(put '(deriv) '+ (lambda (exp var) (make-sum
                           (deriv (addend exp) var) (deriv (augend exp) var))))
(put '(deriv) '* (lambda (exp var) (make-sum
                           (make-product
                            (multiplier exp) (deriv (multiplicand exp) var))
                           (make-product
                            (deriv (multiplier exp) var)  (multiplicand exp))))
(put 'exponentiation (deriv) (lambda (exp var)  (make-product
                                                 (make-product (exponent exp) (make-exponent (base exp) (make-sum (exponent exp) -1))))
                                                 (deriv (base exp) var)))
#| Answer:
|#
