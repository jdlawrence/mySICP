#lang sicp
(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1.0 (* a (+ a 2))) (pi-sum (+ a 4) b))))

;(* 8 (pi-sum 1 2000000))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (inc a)
  (+ a 1))

(define (cube a)
  (* a a a))

(define (sum-cubes a b)
  (sum cube a inc b))

;(sum-cubes 1 3)

(define (pi-term a)
  (/ 1.0 (* a (+ a 2))))

(define (pi-next a)
  (+ a 4))

(define (sum-pi a b)
  (sum pi-term a pi-next b))

;(* 8 (sum-pi 1 1000))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 0 1 0.01)

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (next-simpson x) (+ x (* 2 h)))
  (* (/ h 3.0)
     (+ a
        (+ a (* n h))
        (* 4 (sum cube (+ a h) next-simpson (+ a (* (- n 1) h))    ))
        (* 2 (sum cube (+ a (* 2 h)) next-simpson (+ a (* (- n 2) h))     )))))
(simpson cube 0 1 1)
#|
NOTE: 'n' must be even and must be entered as an integer (i.e. 100) and not as a decimal
(i.e. 100.0) or rounding errors will result
|#