#lang sicp
#| Answer:
Keep increasing low until it's equal to high.
|#

(define (an-integer-between low high)
  (require (<= low high))
  (amb low (an-integer-between (+ low 1 ) high)))
