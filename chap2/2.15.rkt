#lang sicp
(define (par1 r1 r2)
 (div-interval (mul-interval r1 r2)
               (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

#|
Eva Lua Tor is right. When we look at par1 and compare it with par2, we can
see that par1 has three operations involving intervals. R1 * R2, R1 + R2, and
(R1 * R2) / (R1 + R2). Par2 only has one operation, the sum of 1/R1 and 1/R2.

Since each interval has it's own uncertainty already, the more operations we
use that involve the intervals, the more uncertain things will get. In this
case since par2 has three times as many operations involving intervals as
par1, the final percentage of uncertainty calculation is three times as
large.

|#
