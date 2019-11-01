#lang sicp


(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds!"))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (notify-incorrect-password amount)
    "Incorrect password")
  (define (dispatch p m)
    (if (eq? p password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT" m)))
        notify-incorrect-password))
  dispatch)

#| Given version of rand |#
#|
(define rand (let ((x random-init))
               (lambda ()
                 (set! x (rand-update x))
                 x)))
|#

#| Helpers |#
(define random-init 0)

#| A fake random function |#
(define (rand-update n)
  (+ n 5))

#| Answer |#
(define rand 
  (let ((x random-init))
    (define (dispatch action)
      (cond ((eq? action 'generate)
             (begin (set! x (rand-update x))
                    x))
            ((eq? action 'reset)
             (lambda (new-value) (set! x new-value)))))
    dispatch))

(rand 'generate)     
(rand 'generate)     
(rand 'generate)     
(rand 'generate)     
(rand 'generate)     
(rand 'generate)
((rand 'reset) 4)
(rand 'generate)
(rand 'generate)
(rand 'generate)