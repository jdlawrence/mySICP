#lang sicp
; Recursive version of continuous fraction
; To work properly, your index must count up
; You can think of this an outside-in method
(define (cont-frac-r n d k)
  (define (sub i)
    (if (> i k)
        0
        (/ (n i) (+ (d i) (sub (+ i 1))))))
  (sub 1))

; Iterative version of continuous fraction
; NOTE: the golden ratio, phi, appears to be the ratio
; of (n+1)/n, where n is the index of fibonnaci numbers
; This method below takes advantage of that fact but
; doesn't really solve for the cases when n and d don't
; always return 1
(define (cont-frac-i n d k)
  (define (sub k curr next)
    (if (= k 0)
        (/ curr next 1.0)
        (sub (- k 1) next (+ curr next))))
  (sub k 0 1))

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

(/ 1 (cont-frac-r (lambda (i) 1.0) (lambda (i) 1.0) 25))
(/ 1 (cont-frac-i (lambda (i) 1.0) (lambda (i) 1.0) 25))
(/ 1 (cont-frac-J (lambda (i) 1.0) (lambda (i) 1.0) 25))

; NOTE: we need a k of > 10 to get this to within 4
; places of 1.6180, the golden ratio
