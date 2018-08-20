#lang sicp
(define (make-rat n d)
  (let ((g (gcd (abs n) (abs d))))
    (if (< (/ n d) 0)
        (cons (/ (* -1 (abs n)) g) (/ (abs d) g))
        (cons (/ (abs n) g) (/ (abs d) g)))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (display (numer x))
  (display '/)
  (display (denom x))
  (newline))

(define (add-rat x y)
  (make-rat (+ (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (- (* (numer x) (denom y))
               (* (numer y) (denom x)))
            (* (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (* (numer x) (numer y))
            (* (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (* (numer x) (denom y))
            (* (denom x) (numer y))))

(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

;(define one-third (make-rat -1 3))

;(print-rat (add-rat one-third one-third))
(print-rat (make-rat 1 2))
(print-rat (make-rat -1 2))
(print-rat (make-rat 1 -2))
(print-rat (make-rat -1 -2))

;(print-rat (add-rat (make-rat -3 4) (make-rat 1 4)))
;(define (make-rat))