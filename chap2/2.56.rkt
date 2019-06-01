#lang racket
(define (make-sum a1 a2) (list '+ a1 a2))

(make-sum 'x 'y)

#| Given |#
(define (=number? exp num) (and (number? exp) (= exp num)))

#| Answer |#
(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))

(define (base e) (cadr e))
(define (exponent e) (caddr e))

#| Assumes a non-negative exponent |#
(define (** base exponent)
  (if (= 1 exponent)
      base
      (* base (** base (- exponent 1)))))
            
(** 2 4)

(define (make-exponentiation base exponent)
  (cond ((=number? base 0) 0)
        ((=number? exponent 0) 1)
        ((=number? base 1) 1)
        ((=number? exponent 1) base)
        ((and (number? base) (number? exponent)) (** base exponent))
        (else (list '** base exponent))))

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
        ((exponentiation? exp)
         (make-product (exponent exp) (make-exponent (base exp) (- (exponent exp) 1))))
        (else
         (error "unknown expression type: DERIV" exp))))
#| Testing |#
(make-exponentiation 2 4)