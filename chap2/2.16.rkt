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

Par1 and par2 are equivalent expressions when dealing with single variables for which
the variable divided by itself equals 1. For example is x = 5, x/x = 5/5 = 1. But if
y is the interval [99, 101], the resulting interval is [.98, 1.02], which has a greater
range of error than the original. To get from par1 to par2, we just have to divide the
numerator and denominator by (R1 * R2). Normally this would be the same as multiplying by
a form of one, since (R1 * R2)/ (R1 * R2) would be one, but as stated earlier, this is not
the case with intervals.

To define an interval-arithmetic system that does not have this shortcoming, you'd have to
a system where dividing one interval by another makes the first interval smaller. I won't
say that this is impossible, but I have not thought of a way to make the error margin smaller
when doing calculations involving intervals.

|#
