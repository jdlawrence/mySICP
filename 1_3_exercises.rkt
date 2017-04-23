#lang sicp
(define (func a b c)
  (cond ((and (>= a b) (>= a c))
         (cond ((>= b c) (+ (* a a) (* b b)))
               ((> c b) (+ (* a a) (* c c))))
         )

        ((and (>= b a) (>= b c))
         (cond ((>= a c) (+ (* b b) (* a a)))
               ((> c a) (+ (* b b) (* c c))))
         )
        ((and (>= c a) (>= c b))
         (cond ((>= a b) (+ (* c c) (* a a)))
               ((> b a) (+ (* c c) (* b b))))
         )
        )
  
  )
  ;(if (> a b) (* a a) (* b b)))
(func 3 2 1)
                            