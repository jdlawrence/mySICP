#lang sicp
(define (exchange account1 account2)
  (let ((difference (- (account1 'balance)
                       (account2 'balance))))
    ((account1 'withdraw) difference)
    ((account2 'deposit) difference)))

(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))

#| Answer
Ben's procedure will work fine. Notice that the exchange procedure needs the balances of
each account to calculate the difference between the account. In between the time that the
balance of each account has been calculated and the withdrawal and transfer, the balance
could change, and the subsequent amounts after exchange would not be as intended.

In the case of transfer, there is no balance check. There's only the withdraw and deposit,
which can proceeed regardless of the balance in each account changing to interleaving (it is
stated in the problem that the from-account balance as at least the withdrawal amount)
|#


