#lang racket

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (sum? x) (and (pair? x) (eq? (car x) '+)))
(define (product? x) (and (pair? x) (eq? (car x) '*)))
;(define (make-sum a1 a2) (list '+ a1 a2))
;(define (make-product m1 m2) (list '* m1 m2))
(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (addend s) (cadr s))
(define (augend s) (caddr s))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

#|
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
        ;⟨more rules can be added here⟩
        (else (error "unknown expression type: DERIV" exp))))
|#
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
a) The derivatives rules for a sum and a product were taken out and replaced with an generic expression.
The generic expression retrieves the appropriate derivative expression based on the operation tag, and then
calls the operations. We create two selectors, "operator" to choose the appropriate operator expression,
and "operands" to get the expression that we which to carry out the derivative on.

We cannot follow this pattern with "number" or "variable" because there are no operators used in those predicates.

b)
(put '+ '(deriv) (lambda (exp var) (make-sum
                           (deriv (addend exp) var) (deriv (augend exp) var))))
(put '* '(deriv) (lambda (exp var) (make-sum
                           (make-product
                            (multiplier exp) (deriv (multiplicand exp) var))
                           (make-product
                            (deriv (multiplier exp) var)  (multiplicand exp))))
c) (put 'exponentiation (deriv) (lambda (exp var)  (make-product
                                                 (make-product (exponent exp) (make-exponent (base exp) (make-sum (exponent exp) -1))))
                                                 (deriv (base exp) var)))
d) If we changed the dispatch line to ((get (operator exp) 'deriv) (operands exp) var), we could just switch the order of the operation
and the 'deriv tag in the table, ie
(put '+ '(deriv) (lambda (exp var) (make-sum
                           (deriv (addend exp) var) (deriv (augend exp) var))))
|#
;s(deriv '(+ (* 3 x) (* 4 x x)) 'x)
(deriv '(* (* x y) (+ x 3)) 'x)
(deriv '(* x y) 'y)