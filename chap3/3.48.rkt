#lang sicp
#| Answer
If we always serialize the account with the lowest id number first, we can
avoid the deadlock.  This is because we carry out one serialized exchange
completely before attempting the second.


|#
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer))
        (id1 (account1 'get-id))
        (id2 (account2 'get-id)))
    (if (< id1 id2)
        (begin
          ((serializer1 exchange) account1 account2)
          ((serializer2 exchange) account1 account2))
        (begin
          ((serializer2 exchange) account1 account2)
          ((serializer1 exchange) account1 account2)))))
         

(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))

(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request: MAKE-ACCOUNT" m))))
    dispatch))
