#lang sicp
#| Answer
If we don't know in advance which which account we're working with, we cannot get the ids
of each one, and therefore cannot determine the order in which serialization should
proceed. We need to know which accounts are going to be exchanged ahead of time.

If we had a function that took in a list of list of transfer to and from accounts, and
the transfers for that list had to occur in a particular order, this would fail.
|#