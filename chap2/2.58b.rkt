#lang racket
#| Given |#
(define (=number? exp num) (and (number? exp) (= exp num)))

(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

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

(define (make-exponent base exponent) (list '** base exponent))

;(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
(define (sum? x) (and (pair? x) (eq? (cadr x) '+)))
(define (product? x) (and (pair? x) (eq? (cadr x) '*)))

#| Answer |#
(define (addend s) (car s))
(define (augend s) (if (null? (cdr s))
                       (car s)
                       (caddr s)))

(define (multiplier p) (car p))
(define (multiplicand p) (if (null? (cdr p))
                             (car p)
                             (caddr p)))

(= (cadddr '(x + 2 * y)) '))

;(define (reformat expr)
  ;(if (= (caddr expr
#| Testing |#
(sum? '(3 + x))
(product? '(3 * x))
;(addend '(3 + x))
;(augend '(3 + x))
;(addend '(3 + (x + (y + z))))
;(augend '(3 + (x + (y + z))))
;(multiplier '(x * (y * (z * (q)))))
;(multiplicand '(x * (y)))
;(multiplicand '(x * (y * (z * (q)))))

#|
(define (make-exponentiation base exponent)
  (cond ((=number? base 0) 0)
        ((=number? exponent 0) 1)
        ((=number? base 1) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) (** base exponent))
        (else (list '** base exponent))))
|#

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp) (make-sum (deriv (addend exp) var)
                              (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ;((exponentiation? exp)
         ;(make-product (exponent exp) (make-exponent (base exp) (make-sum (exponent exp) -1))))
        (else
         (error "unknown expression type: DERIV" exp))))

#| Testing |#
(deriv '(x * y) 'x)
(deriv '(x + (3 * (x + (y + 2)))) 'x)