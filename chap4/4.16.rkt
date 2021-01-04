#lang racket

#| Answer:
|#

;a)
;If the value associated with the variable is equal to unassigned, we
;signal an error
#|
(define (lookup-variable-value var env)
  (define (env-loop env)
    (define (scan vars vals)
      (cond ((null? vars)
             (env-loop (enclosing-environment env)))
            ((eq? var (car vars))
             (if (eq? '*unassigned* (car vals))
                 (error "Value unassigned" var)
                 (car vals)))
            (else (scan (cdr vars) (cdr vals)))))
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let ((frame (first-frame env)))
          (scan (frame-variables frame)
                (frame-values frame)))))
  (env-loop env))
|#

;b)

(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

(define (definition? exp) (tagged-list? exp 'define))
(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp) ; formal parameters
                   (cddr exp)))) ; body

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))



(define (make-let bindings body) 
  (cons 'let (cons bindings body))) 
(define (scan-out-defines body) 
  (define (append x y) 
    (if (null? x) y (cons (car x) (append (cdr x) y)))) 
  (let* ((definitions
           ; The definitions all start with 'define
           (filter (lambda (x) 
                     (and (pair? x) (definition?  x))) body))
         ; Every other term is not a definition
         (non-definitions 
          (filter (lambda (x) 
                    (or (not (pair? x)) 
                        (not (definition? x)))) body)) 
         (let-vars (map definition-variable definitions)) 
         (let-vals (map definition-value definitions)) 
         (let-bindings 
          (map (lambda (x) (list x ''*unassigned*)) let-vars)) 
         (assignments 
          (map (lambda (x y) (list 'set! x y)) let-vars let-vals))) 
    (if (null? let-bindings) 
        body 
        (list (make-let let-bindings (append assignments non-definitions))))))

;c)
(define (make-procedure parameters body env) 
     (list 'procedure parameters (scan-out-defines body) env))

; We should install this in make-procedure and not procedure body so that we can avoid repeated
; calls to it.

#| Testing |#
(define ex1 '(lambda (x)
               (define x1 5)
               (define x2 6)
               (+ x x1 x2)))

(scan-out-defines ex1)



;(define (scan-out-defines body)
;Get all defines from body
  


