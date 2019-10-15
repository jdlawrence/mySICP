#lang racket
#| Answer:

|#

(define (raise-integer->rational int)
  (make-rat int 1))

(define (raise-rational->real rat)
  (/ (numer rat) (denom rat)))

(define (raise-real->complex rn)
  (make-from-real-imag rn 0))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((t1->t2 (get-coercion type1 type2))
                      (t2->t1 (get-coercion type2 type1)))
                  (cond (t1->t2
                         (apply-generic op (t1->t2 a1) a2))
                        (t2->t1
                         (apply-generic op a1 (t2->t1 a2)))
                        (else (error "No method for these types"
                                     (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))

(define (steps-to-top element-type highest-level)
  (if (eq? element-type highest-level)
      0
      (+ 1 (steps-to-top (raise element-type) highest-level))))

(define (apply-generic-raise op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((type1-higher (< (steps-to-top type-1 'complex) (step-to-top type2 'complex)))
                      (type2-higher (< (steps-to-top type-2'complex) (step-to-top type1 'complex)))
                  (cond (type1-higher
                         (apply-generic op a1 (raise a2))
                        (type2-higher
                         (apply-generic op (raise a1)  a2))
                        (else (error "No method for these types"
                                     (list op type-tags))))))
              (error "No method for these types"
                     (list op type-tags)))))))
