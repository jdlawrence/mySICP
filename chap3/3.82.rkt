#lang sicp
#| Necessary for stream manipulation |#
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

(define (display-n-terms s n)
  (define (sub count)
    (if (= count n)
        (stream-ref s count)
        (begin
          (display (stream-ref s count))
          (display "\n")
          (sub (+ count 1)))))
  (sub 0))

#| End of stream stuff |#

#| From exercise 3.5: |#

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (square n)
  (* n n))

(define (inside-circle cx cy r x1 y1)
  (<= (+ (square (- cx x1)) (square (- cy y1)))
      (square r)))
  
(define (predicate cx cy r x1 x2 y1 y2)
  (inside-circle cx cy r (random-in-range x1 x2) (random-in-range y1 y2)))

#| Old: 
(define (monte-carlo experiment-stream passed failed)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0.0)
           (/ trials-passed (* trials 1.0)))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))
|#

#| Answer |#
(define (predicate-stream x1 x2 y1 y2)
  (cons-stream (inside-circle 0.0 0.0 1.0 (random-in-range x1 x2) (random-in-range y1 y2))
               (predicate-stream x1 x2 y1 y2))) 

;(stream-ref ones 1)
(define unit-circ-stream (predicate-stream 1.0 -1.0 1.0 -1.0))
;(display-n-terms unit-circ-stream 5)

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define dummy-c (cons-stream #t (cons-stream #f (cons-stream #t (cons-stream #t (cons-stream #f integers))))))

#| TODO: WORK ON THIS |#
(define (estimate-integral x1 x2 y1 y2 )
  (let (
        (area (* (- x1 x2) (- y1 y2)))
        (pred-stream (predicate-stream x1 x2 y1 y2))
        )
    (stream-map
     (lambda (p) (* p area))
     (monte-carlo pred-stream 0 0))))

(define pi(estimate-integral 1.0 -1.0 1.0 -1.0))

#| Older attempt, less modular: 
(define pi2
  (stream-map
   (lambda (p) (* p 4.0))
   (monte-carlo unit-circ-stream 0 0)))

|#

(stream-ref pi 10000)




