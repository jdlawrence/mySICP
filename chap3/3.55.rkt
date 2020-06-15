#lang sicp

(define (display-line x) (newline) (display x))
(define (stream-car stream)
  (car stream))

(define the-empty-stream '())

(define (stream-cdr stream)
  (force (cdr stream)))

(define (stream-null? stream)
  (null? stream))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

#|
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))
|#

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (stream-enumerate-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream
       low
       (stream-enumerate-interval (+ low 1) high))))

(define (show x)
  (display-line x)
  x)

(define (display-stream s)
  (stream-for-each display-line s))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                       pred
                       (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

(define ones (cons-stream 1 ones))

(define (add-streams s1 s2) (stream-map + s1 s2))

(define integers
(cons-stream 1 (add-streams ones integers)))


(define (mul-streams s1 s2)
  (stream-map * s1 s2))


(define factorials
  (cons-stream 1 (mul-streams factorials (stream-cdr integers))))

#| Answer |#
#|
(define (partial-sums s)
  (define (sub ss sum)
    (cons-stream (+ sum (stream-car s)) (sub (stream-cdr ss) (+ sum (stream-car ss)))))
  (sub s -1))
|#

#| More concise solution |#
 (define (partial-sums s) 
   (add-streams s (cons-stream 0 (partial-sums s)))) 

;(map stream-car ones integers)
;(define j (stream-map (lambda (x y z ) (* 1 x y z)) (add-streams integers integers) (add-streams integers integers) integers))
(define j (stream-map (lambda (x y) (* 3 x y)) integers (add-streams integers integers)))
;(stream-ref j 0)
(stream-ref integers 2)
;(stream-ref j 4)
#| Testing |#
(define ex (partial-sums integers))
;(stream-ref ex 0)
;(stream-ref ex 1)
(stream-ref ex 2)
;(stream-ref ex 3)
;(stream-ref ex 4)
;(stream-ref ex 5)
#|
(stream-ref factorials 0)
(stream-ref factorials 1)
(stream-ref factorials 2)
(stream-ref factorials 3)
(stream-ref factorials 4)
(stream-ref factorials 5)
|#


