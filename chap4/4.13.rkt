#lang sicp

#| Given: |#
(define (enclosing-environment env) (cdr env))
(define (first-frame env) (car env))
(define the-empty-environment '())

(define (make-frame variables values)
  (cons variables values))
(define (frame-variables frame) (car frame))
(define (frame-values frame) (cdr frame))
(define (add-binding-to-frame! var val frame)
  (set-car! frame (cons var (car frame)))
  (set-cdr! frame (cons val (cdr frame))))

(define (extend-environment vars vals base-env)
  (if (= (length vars) (length vals))
      (cons (make-frame vars vals) base-env)
      (if (< (length vars) (length vals))
          (error "Too many arguments supplied" vars vals)
          (error "Too few arguments supplied" vars vals))))
    
#| Answer |#
;NOTE: This only works if you're using 'make-unbound' on the first frame of the environment.
;To use in any frame would require make copies of all the frame and then splicing in the
;the altered frame
(define (splice var varsList resultVars valsList resultVals)
  (cond ((null? varsList) '())
        ((eq? var (car varsList))
         (make-frame (append resultVars (cdr varsList)) (append resultVals (cdr valsList))))
        (else (splice var 
                      (cdr varsList) (append resultVars (list (car varsList)))
                      (cdr valsList) (append resultVals (list (car valsList)))))))

(define (make-unbound! var env)
  (define (env-loop currentEnv)
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let* ((frame (first-frame currentEnv))
               (vars (frame-variables frame))
               (vals (frame-values frame))
               (result (splice var vars '() vals '())))
          (cond ((null? result) (env-loop (enclosing-environment currentEnv)))
                (else
                 (extend-environment
                  (frame-variables result)
                  (frame-values result)
                  (enclosing-environment currentEnv))
                 )))))
  (env-loop env))
;(define (make-unbound var env

#| Testing |#
(define exVars '(jamil akeem kyle))
(define exVals '(36 34 32))
;(splice 'akeem exVars '() exVals '())
(define myEnv (extend-environment '(jamil akeem kyle) '(36 34 32) '()))
(define newFamily (extend-environment '(robin kendrick) '(29 0) myEnv))
;myEnv
;newFamily  
(make-unbound! 'robin newFamily)
  





