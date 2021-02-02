#lang sicp
(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env) (if (true? (pproc env))
                      (cproc env)
                      (aproc env)))))

(define (analyze-if-fail exp) 
  (let ((cproc (analyze (if-fail-cond exp))) 
        (aproc (analyze (if-fail-alt exp)))) 
    (lambda (env succeed fail) 
      (cproc env 
             succeed 
             (lambda () 
               (aproc env succeed fail))))))

; We start with the analyze-if:
(define (analyze-if exp)
  (let ((pproc (analyze (if-predicate exp)))
        (cproc (analyze (if-consequent exp)))
        (aproc (analyze (if-alternative exp))))
    (lambda (env succeed fail)
      (pproc env
             (lambda (pred-value fail)
               (if (true? pred-value)
                   (cproc env succeed fail)
                   (aproc env succeed fail)))
             fail))))
#| Answer:

|#
(if-fail? analyze-if-fail)

(define (if-fail-success exp) (cadr exp))
(define (if-fail-failure exp) (caddr exp))

(define (analyze-if-fail exp)
  (let (
        (cproc (analyze (if-fail-successs exp)))
        (fproc (analyze (if-fail-failure exp)))
        )
    (lambda (env succeed fail)
      (cproc env
             (lambda (value fail2)
               (succeed fail2))
             (lambda ()
               (fproc env succeed fail))))))

    