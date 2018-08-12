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

; Produces 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, 1, 1, 10,...
(define (dEuler n)
  (if (= (remainder n 3) 2)
      (* (+ n 1) (/ 2 3))
      1))

; Testing with my recursion cont-frac
(+ 2 (cont-frac-r (lambda (i) 1.0)
             dEuler
             25))

; Testing with my iterative cont-frac
(+ 2 (cont-frac-J (lambda (i) 1.0)
             dEuler
             25))