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

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor))
              stream))


(define (integrate-series input)
  (define (sub term-num s)
    (if (stream-null? s)
        the-empty-stream
        (cons-stream
         (* (/ 1 term-num) (stream-car s))
         (sub (+ term-num 1) (stream-cdr s)))))
  (sub 1 input))

(define cosine-series (cons-stream 1 (integrate-series (scale-stream sine-series -1))))
(define sine-series (cons-stream 0 (integrate-series cosine-series)))

(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1) (stream-car s2))
               (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                            (mul-series s1 (stream-cdr s2)))))

(define (invert-unit-series s)
  (cons-stream 1 (scale-stream (mul-series (stream-cdr s) (invert-unit-series s)) -1)))

(define (div-series s1 s2)
  (if (= (stream-car s2) 0)
      (error "cannot divide by zero")
      (mul-series s1 (invert-unit-series s2))))

(define (average x y)
  (/ (+ x y) 2))

#| Square root iterative function |#
(define (sqrt-improve guess x)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream
     1.0
     (stream-map (lambda (guess) (sqrt-improve guess x))
                 guesses)))
  guesses)

(define (stream-limit s1 tolerance)
  #| Something like this: |#
  (if (> tolerance (abs (- (stream-car s1) (stream-car (stream-cdr s1)))))
      (stream-car (stream-cdr s1))
      (stream-limit (stream-cdr s1) tolerance)))

(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))


#| Testing |#
(sqrt 32 0.001)
(stream-ref (sqrt-stream 32) 0)
(stream-ref (sqrt-stream 32) 1)
(stream-ref (sqrt-stream 32) 2)
(stream-ref (sqrt-stream 32) 3)
(stream-ref (sqrt-stream 32) 4)
(stream-ref (sqrt-stream 32) 5)
