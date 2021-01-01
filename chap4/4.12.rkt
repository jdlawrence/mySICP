#lang racket
(define ns (make-base-namespace))

;From lookup-variable-value
(define (scan vars vals)
  (cond ((null? vars)
         (env-loop (enclosing-environment env)))
        ((eq? var (car vars)) (car vals))
        (else (scan (cdr vars) (cdr vals)))))

;From set-variable-value
(define (scan vars vals)
  (cond ((null? vars)
         (env-loop (enclosing-environment env)))
        ((eq? var (car vars)) (set-car! vals val))
        (else (scan (cdr vars) (cdr vals)))))

;From define-variable
(define (scan vars vals)
  (cond ((null? vars)
         (add-binding-to-frame! var val frame))
        ((eq? var (car vars)) (set-car! vals val))
        (else (scan (cdr vars) (cdr vals)))))

;All three functions need to scan the list of variables. Once we either
;find the variable we're looking for or reach the end of the list (null? vars)
;each function can take its own path.
;The commonality is that we should scan until we find the value we're looking for,
;and when we find it, we return the list of values with the desired value at the head
;of the list

