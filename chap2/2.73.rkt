#lang racket

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum (make-product
                    (multiplier exp)
                    (deriv (multiplicand exp) var))
                   (make-product
                    (deriv (multiplier exp) var)
                    (multiplicand exp))))
        ⟨more rules can be added here⟩
        (else (error "unknown expression type: DERIV" exp))))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

#| Answer:
a) The derivatives rules for a sum and a product were taken out and replaced with an generic expression.
The generic expression retrieves the appropriate derivative expression based on the operation tag, and then
calls the operations. We create two selectors, "operator" to choose the appropriate operator expression,
and "operands" to get the expression that we which to carry out the derivative on.

We cannot follow this pattern with "number" or "variable" because there are no operators used in those predicates.
|#
