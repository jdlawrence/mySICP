#lang racket
#|
(letrec
    ((fact (lambda (n)
             (if (= n 1)
                 1
                 (* n (fact (- n 1)))
                 )
             )))
  (fact 10))
|#
(define a
  (lambda (ft k)
    (if (= k 1)
        1
        (* k (ft ft (- k 1)))
        )
    )) 

((lambda (n)
   ((lambda (fact) (fact fact n))
    a))
 3)
