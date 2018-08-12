#lang sicp
(define pi 3.141592653589793238462643383279502884197169399375105820974944)
; Recursive version of continuous fraction
; To work properly, your index must count up
; You can think of this an outside-in method
(define (cont-frac-r n d k)
  (define (sub i)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (sub (+ i 1))))))
  (sub 1))

; Here's another iterative solution that actually
; uses n and d properly
; To work properly, your index must count down. This
; is because we starting with the inner-most result,
; the highest index, and moving outward, which counts
; down.
(define (cont-frac-J n d k)
  (define (sub i result)
    (if (= i 0)
        result
        (sub (- i 1) (/ (n i) (+ (d i) result)))))
  (sub k 0))

;(/ 1 (cont-frac-r (lambda (i) 1.0) (lambda (i) 1.0) 25))
;(/ 1 (cont-frac-J (lambda (i) 1.0) (lambda (i) 1.0) 25))

; NOTE: we need a k of > 10 to get this to within 4
; places of 1.6180, the golden ratio


(define xOrXSquared (lambda (i x)
          (if (= i 1)
              x
              (* x x))))

(define odds (lambda (i)
   (- (* 2 i) 1)))

(define (tan-cf x k)
  (define (sub i result)
    (if (= i 0)
        result
        (sub (- i 1) (/ (xOrXSquared i x) (- (odds i) result)))))
  (sub k 0))

(tan (/ pi 6))
(tan-cf (/ pi 6) 25)