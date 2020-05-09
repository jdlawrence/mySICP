#lang sicp

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance
                     (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance)
             ((protected
               (lambda () balance)))) ; serialized
            (else
             (error "Unknown request: MAKE-ACCOUNT"
                    m))))
    dispatch))

#| Answer
Having a protected balance is useful. Let's say a person invokes the balance function.
The balance is accessed and returned to the user as $50, but another person makes a
withdrawal of $40. Now the first person goes and tries to withdraw $50, but the balance is
only $10. He will receive a message of insufficient funds, but will be confused why he
receives it.
|#


