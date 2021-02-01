#lang sicp

#| Answer:

This involves not-calling the reassignment near the *2* to set the var back to it's old-value.
Instead I just passed a dummy lambda that just returns the empty list

|#
(define (analyze-assignment exp)
  (let ((var (assignment-variable exp))
        (vproc (analyze (assignment-value exp))))
    (lambda (env succeed fail)
      (vproc env
             (lambda (val fail2)        ; *1*
               (let ((old-value
                      (lookup-variable-value var env))) 
                 (set-variable-value! var val env)
                 (succeed 'ok
                          (lambda ()    ; *2*
                            ; (set-variable-value! var
                            ;                      old-value
                            ;                      env)
                            ((lambda () '()))
                            (fail2)))))
             fail))))
