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

(define sum 0)
(define (accum x) (set! sum (+ x sum)) sum)
(define seq
  (stream-map accum
              (stream-enumerate-interval 1 200)))
(define y (stream-filter even? seq))
(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))
(stream-ref seq 15)
(stream-ref y 7)
(display-stream z)

#| Answers:
Output:
sum is the growing sum of the numbers of 1 to 20.

136 -> the 7th total after all odd totals have been filtered out

below: the totals that are divisible by 5
10
15
45
55
105
120
190
210

If we had implemented (delay ⟨exp⟩) simply as (lambda () ⟨exp⟩) without using memo-proc,
the totals would be the same, but it would take much longer to calculate.

|#