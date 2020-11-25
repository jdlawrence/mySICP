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

(define (partial-sums s) 
  (add-streams s (cons-stream 0 (partial-sums s))))

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

(define (display-n-terms s n)
  (define (sub count)
    (if (= count n)
        (stream-ref s count)
        (begin
          (display (stream-ref s count))
          (display "\n")
          (sub (+ count 1)))))
  (sub 0))

(define (square x) (* x x))

(define (sign-change-detector curr prev)
  (cond ((and (>= curr 0) (< prev 0)) 1)
        ((and (>= prev 0) (< curr 0)) -1)
        (else 0)))


#| Old definition:
(define (make-zero-crossings input-stream last-value)
  (cons-stream
   (sign-change-detector (stream-car input-stream) last-value)
   (make-zero-crossings (stream-cdr input-stream)
                        (stream-car input-stream))))
|#

;Used in testing: 
(define sense-data (cons-stream -12 (cons-stream 22 (cons-stream -3 (cons-stream 0 (cons-stream -2 (cons-stream -87 (cons-stream 5 integers))))))))

#|
(define zero-crossings
  (stream-map sign-change-detector
              sense-data
             (cons-stream 0 sense-data)))
|#

#| Louis Reasoner's definition (wrong) |#
#|
(define (make-zero-crossings input-stream last-value)
  (let ((avpt (/ (+ (stream-car input-stream)
                    last-value)
                 2)))
    (cons-stream
     (sign-change-detector avpt last-value)
     (make-zero-crossings
      (stream-cdr input-stream) avpt))))
|#

#| Explanation: We need to calculate whether or not there was a change between the last average point and the
next average point. Louis' old solutions detected one between the average point and the last value, where it needed
to be the last average point.
|#

#| From previous exercise |#
(define (make-zero-crossings input-stream last-value last-avpt) 
  (let ((avpt (/ (+ (stream-car input-stream)
                    last-value)
                 2))) 
    (cons-stream
     (sign-change-detector avpt last-avpt) 
     (make-zero-crossings
      (stream-cdr input-stream) 
      (stream-car input-stream) 
      avpt))))

(define (smooth input-stream last-value)
  (let ((avpt (/ (+ (stream-car input-stream) last-value) 2)))
  (cons-stream avpt
               (smooth (stream-cdr input-stream) (stream-car input-stream)))))
#| Testing |#
;(sign-change-detector 1 -4)
;(display-n-terms (smooth sense-data 0) 10)


#| Answer for 3.76 |#
;(define zero-crossings (make-zero-crossings sense-data 0 4))
(define zero-crossings
  (stream-map sign-change-detector
              (smooth sense-data 0)
             (cons-stream 0 (smooth sense-data 0))))
(display-n-terms zero-crossings 10)

