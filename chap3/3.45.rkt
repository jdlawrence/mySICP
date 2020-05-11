#lang sicp
(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))

#| Answer
To ensure proper balance fidelity, each account needs in own serializer. With Louis's method, they are sharing
the serializer, and serialized exchange happens, we won't get the correct balance in each account.
|#


