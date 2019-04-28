#lang sicp
(#%require sicp-pict)
;(paint einstein)

#|
(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))


(define (up-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller)))))
|#

#| Answer |#
(define (split op1 op2)
  (lambda (painter n)
    (define (sub a-painter index)
      (if (= index 0)
          a-painter
          (let ((smaller (sub a-painter (- index 1))))
            (op1 a-painter (op2 smaller smaller)))))
    (sub painter n)))

#| Testing |#
(define right-split (split beside below))
(define up-split (split below beside))
(paint (right-split diagonal-shading 3))
(paint (up-split diagonal-shading 1))

