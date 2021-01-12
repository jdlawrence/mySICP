#lang sicp

#| Answer:
The first time we call count, it's 1. It started out as 0, but when we defined
|#

(define count 0) ; count is 0
(define (id x) (set! count (+ count 1)) x)
count ; count is 0
(define w (id (id 10))) 
count ; count is 1 since we invoked id when assigning w
w ; Call the w function. It returns 10 and increments count
count ; count is now 2

#|
In a regular environment count would jump from 0 to 2, but here, even though we are
calling id twice, ie (id (id 10), one of these calls is memoized. Therefore, we just
count sequentially.
|#
