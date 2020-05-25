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

(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

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

(define x
  (stream-map show
              (stream-enumerate-interval 0 10)))

;(stream-ref x 5)
;(stream-ref x 7)

#| Answer:
The output is:

Why is 0 an output?
0
1
2
3
4
55

6
77

The stream-map is called with "show" as its procedure and stream-enumerate-interval
as the data. Stream-enumerate-interval produce (cons 0 promise) which is passed to stream-map.
Stream map call "show" on the "car" of this stream, which outputs 0. This continues as we count
from 0 until 5, when stream-ref outputs 5, the value passed to it. We then output 6, and 7, and
a second 7 due to the call to (stream-ref x 7).

|#