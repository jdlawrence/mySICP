#lang racket
; Given version of "analyze-sequence"
(define (analyze-sequence exps)
  (define (sequentially proc1 proc2);Take in two procedures
    (lambda (env) (proc1 env) (proc2 env)));Return a func that takes in an env, and calls the two procedures in that env
  (define (loop first-proc rest-procs);loop takes in a first proc and rest of procedures
    (if (null? rest-procs)
        first-proc ;If the rest of the procs are null, return the first proc
        (loop (sequentially first-proc (car rest-procs));Otherwise, call "sequentially" with the first proc "car" of the
              ;rest of the procedures (aka the second procedure)
              (cdr rest-procs))));call loop recursively with the the third and rest of the procs 
  (let ((procs (map analyze exps))); Let the "procs" be the analyzed version of all the expressions
    (if (null? procs) (error "Empty sequence: ANALYZE")); If there are no procs, throw an error
    (loop (car procs) (cdr procs))));Otherwise, call loop with the first proc and rest of procs

; Alyssa's version of "analyze-sequence"
(define (analyze-sequence exps)
  (define (execute-sequence procs env);Execute-sequence takes in procs and an env
    (cond ((null? (cdr procs))
           ((car procs) env)); If the rest of the procs are null, invoke the first proc in the supplied env
          (else
           ((car procs) env)
           (execute-sequence (cdr procs) env))));Otherwise, invoke the first proc in the environment, and recursively
  ;call execute-sequence with the rest of the procs
  (let ((procs (map analyze exps))); Let "procs" be the analyzed version of the all the expressions
    (if (null? procs)
        (error "Empty sequence: ANALYZE")); If there are no procs, throw an error
    (lambda (env)
      (execute-sequence procs env))));Otherwise, call execute-sequence with the procs and the given env

#| Answer:
The given version return a lambda that takes in an env, and calls the procs in that environment at a later time. It also
calls the procs two a time, whereas Alyssa's version calls them one at a time. If there was a proc that had two expressions,
the given version would call them simultaneously, whereas Alyssa's would call them one at a time.
|#