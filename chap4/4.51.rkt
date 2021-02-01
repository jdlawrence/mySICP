#lang sicp

; Old definition
(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail)         ; *1*
               (let ((old-value
                      (lookup-variable-value var env))) 
                 (set-variable-value! var val env)
                 (succeed 'ok
                          (lambda ()    ; *2*
                            (set-variable-value! var
                                                 old-value
                                                 env)
                            (fail)))))
             fail))))
#| Answer:

This involves not-calling the reassignment near the *2* to set the var back to it's old-value.
Instead we just call set with vproc and never reset the value.

If we just the normal version of this function, we'll get (a b 1), (a c 1), (b a 1), etc

|#
(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)        ; *1*
               (set-variable-value! var val env) 
               (succeed 'ok  fail2)) 
             fail))))