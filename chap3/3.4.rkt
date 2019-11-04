#lang racket
#| Answer |#
(define (call-the-cops)
  "Someone is trying to hack you! Call the cops!!")

(define (make-account balance password)
  (define count-wrong 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds!"))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (notify-incorrect-password amount)
    (set! count-wrong (+ 1 count-wrong))
    (if (< count-wrong 7)
        "Incorrect password"
        (call-the-cops)))
  ;"Incorrect password")
  (define (dispatch p m)
    (if (eq? p password)
        (begin (set! count-wrong 0)
               (cond ((eq? m 'withdraw) withdraw)
                     ((eq? m 'deposit) deposit)
                     (else (error "Unknown request -- MAKE-ACCOUNT" m))))
        notify-incorrect-password))
  dispatch)
   
               
#| Testing |#
(define acc (make-account 100 'abc123))
acc

((acc 'abc123 'deposit) 50)
((acc 'abc123 'deposit) 75)
((acc 'abc123 'withdraw) 750)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'abc123 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)
((acc 'secret-password 'withdraw) 40)