#| Answer: |#

#|
Since we are using "let" we're adding an extra frame. Instead of using let, we can
just use "define" at the beginning of the body.
|#

;Instead of:
(
 (let
     ((x1 '*unassigned*)
      (x2 '*unassigned*))
   (set! x1 5)
   (set! x2 6)
   lambda (x) (+ x x1 x2)))

;We can do:

(lambda (x)
  (define x1 '*unassigned)
  (define x2 '*unassigned)
  (set! x1 5)
  (set! x2 6)
  lambda (x) (+ x x1 x2)))
)



