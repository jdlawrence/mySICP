#lang sicp
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
 (lambda (f) (lambda (x) (f ((n f) x) ))))

(define xVal 0)

(define (fEx x) (+ x 2))

((zero fEx) xVal) ;returns 0

(((add-1 zero) fEx) xVal) ; return 2

(define one (add-1 zero))
(define two (add-1 one))
(define three (add-1 two))
(define four (add-1 three))

(add-1 zero)
(lambda (f) (lambda (x) (f ((zero f) x) )))
(lambda (f) (lambda (x) (f x) ))
; Meaning essentially (f x)

(add-1 one)
(lambda (f) (lambda (x) (f ((one f) x) )))
(lambda (f) (lambda (x) (f (f x)) ))
; Meaning essentially (f (f x))

(define (add m n)
  (lambda (f)
    (lambda (x)
      ((m f) ((n f) x)))))

(((add three four) fEx) xVal) ; Outputs 14 because our f adds two everytime
#|
one is (f x)
two is (f (f x))

+, meaning addition, is f (m + n) number of times
For ex, if m is three, and n is four, three + four is
(f (f (f (f (f (f (f x)))))))
|#


