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

(define (euler-transform s)
  (let ((s0 (stream-ref s 0)) ; Sn-1
        (s1 (stream-ref s 1)) ; Sn
        (s2 (stream-ref s 2))) ; Sn+1
    (cons-stream (- s2 (/ (square (- s2 s1))
                          (+ s0 (* -2 s1) s2)))
                 (euler-transform (stream-cdr s)))))

(define (make-tableau transform s)
  (cons-stream s (make-tableau transform (transform s))))

(define (accelerated-sequence transform s)
  (stream-map stream-car (make-tableau transform s)))


(define (interleave s1 s2)
  (if (stream-null? s1)
      s2
      (cons-stream (stream-car s1)
                   (interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (pairs (stream-cdr s) (stream-cdr t)))))

(define ex (pairs integers integers))

#| Answer
The pairs with 1 in the first coordinate, ie (1, 2), (1, 3), (1, 4), etc, occur every other element start with
(1,2) at element 2. So pair (1, 100) will be the 100 * 2 -2 = 198th pair, and 197 will occur before it.

The 2s pairs, ie (2,3), (2,4), (2,5), etc, start with (2,2) as the third element, (2,3) as the 5th element, (2,4) as the 9th element,
and they continue occurring every 4th element.

The 3s pairs, ie, (3, 4), (3,5), (3,6), etc start with (3,3) as the 7th element, (3,4) as the 11th element, and continue subsequently
occurring at every 8th element after this.

The 4s parirs, ie, (4,5), (4, 6), (4,7), etc, start with (4,4) as the 15th element, (4,5) as the 23rd element, and continue subsequently
occurring at every 16th element after this.

So a pattern, the first element, for a matching pair (n,n), ie (1,1), (2,2), (3,3), etc will occur as the 2^n - 1 element.
The next pair (n, n+1) will follow 2^(n-1) elements later, or 2^n + 2^(n-1) - 1 element. Subsequent elements with be every 2^n from the
second pair.

Final answers:
(1, 100) is the 198th pair, 197 pairs precede it
(99, 100) is the 2^99 + 2^98 - 1 pair, and 2^99 + 2^98 - 2 pairs precede it
(100, 100) is the 2^100 - 1 pair, and 2^100 - 2 pairs precede it.

Formulas:
Given (m, n), if
n-m = 0, (m, n) is the 2^n - 1 pair
n-m = 1, (m, n) is the 2^n + 2^(n-1) - 1 pair
n-m > 1, (m, n) is the 2^n + 2^(n-1) + (n - m - 1)*2^n - 1 pair

|#


#| Testing |#
(display-n-terms ex 500)