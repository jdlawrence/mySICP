#lang racket
#| Answer |#

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
   
               

(define acc (make-account 100 'abc123))
acc

((acc 'abc123 'deposit) 50)
((acc 'abc123 'deposit) 75)
((acc 'abc123 'withdraw) 750)
((acc 'secret-password 'withdraw) 40)