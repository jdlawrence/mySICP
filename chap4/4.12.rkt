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
;The commonality is that we should scan until we find the value we're looking for,
;and when we find it, we return the list of values with the desired value at the head
;of the list. If we don't find it, we should return an empty list.

(define (search var vars vals)
  (cond ((null? vars) '())
        ((eq? var (car vars)) vals)
        (else (search var (cdr vars) (cdr vals)))))

(define (lookup-variable-value var env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable" var)
        (let* (
               (frame (first-frame env))
               (searchResult (search var (frame-variables frame) (frame-values frame)))
               )
          (cond ((null? searchResult) (env-loop (enclosing-environment env)))
                (else (car searchResult))))))
  (env-loop env))

(define (set-variable-value! var val env)
  (define (env-loop env)
    (if (eq? env the-empty-environment)
        (error "Unbound variable: SET!" var)
        (let* (
               (frame (first-frame env))
               (searchResult (search var (frame-variables frame) (frame-values frame)))
               )
          (cond ((null? searchResult) (env-loop (enclosing-environment env)))
                (else (set-car! searchResult val))))))
  (env-loop env))

(define (define-variable! var val env)
  (let*
      (
       (frame (first-frame env))
       (searchResult (search var (frame-variables frame) (frame-values frame)))
       )
    (cond ((null? searchResult) (add-binding-to-frame! var val frame))
          (else (set-car! searchResult val)))))

#| Testing |#
;(define nullEnv (extend-environment '() '() '()))
;(lookup-variable-value 'jamil nullEnv)
(define myEnv (extend-environment '(jamil akeem kyle) '(36 34 32) '()))
(define newFamily (extend-environment '(robin kendrick) '(29 0) myEnv))
(lookup-variable-value 'jamil newFamily)
(set-variable-value! 'jamil 37 myEnv)
(lookup-variable-value 'jamil newFamily)
;(lookup-variable-value 'jamil myEnv)
;(define-variable! 'newBrother  40 myEnv)
(define-variable! 'newBaby -1 newFamily)
newFamily

