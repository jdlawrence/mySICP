#lang racket
(define ex (list 1 2 3 4 5 6 7 8))
(define ex2 (list '+ 1 2))

(cadr ex)
(cddr ex)
(cdddr ex)
(cddddr ex)

(cddr ex2)

(define (add2 x)
  (let ((a 5)
    (b 6))
    (+ a b x)))

(define (even-or-odd n)
  (if (= 0 (modulo n 2))
      'even
      'odd))


(even-or-odd 7)
(even-or-odd 6)
(add2 3)

(equal? 'jamil 'jamil)
(equal? 'jamil 'kyle)
(null? '())