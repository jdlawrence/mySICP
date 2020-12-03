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

#| Old version of rand |#
#|
(define rand (let ((x random-init))
               (lambda ()
                 (set! x (rand-update x))
                 x)))
|#




#| Helpers |#
(define random-init 11)

#| A fake random function |#
(define (rand-update n)
  ;(+ n 5))
  (random 500000))

#| Given: |#
(define random-numbers
  (cons-stream
   random-init
   (stream-map rand-update random-numbers)))

(define (map-successive-pairs f s)
  (cons-stream
   (f (stream-car s) (stream-car (stream-cdr s)))
   (map-successive-pairs f (stream-cdr (stream-cdr s)))))

(define cesaro-stream
  (map-successive-pairs
   (lambda (r1 r2) (= (gcd r1 r2) 1))
   random-numbers))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
     (/ passed (+ passed failed))
     (monte-carlo
      (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define pi
  (stream-map
   (lambda (p) (sqrt (/ 6 p)))
   (monte-carlo cesaro-stream 0 0)))

#| Old Definition |#
(define rand-old 
  (let ((x random-init))
    (define (dispatch action)
      (cond ((eq? action 'generate)
             (begin (set! x (rand-update x))
                    x))
            ((eq? action 'reset)
             (lambda (new-value) (set! x new-value)))))
    dispatch))

#|
(define rand
  (define (dispatch action)
    (cons ((eq? action 'generate)
           (cons-stream
            
|#

#| Answer |#
(define (rand request-stream) 
  (let ((req (stream-car request-stream))) ;Grab the first command from the request stream 
    (let ((random-init
           ; If the command is 'reset, random-init is the reset value. Else, random-init stays the same
           (if (eq? 'reset (car req))
               (cadr req) 
               random-init))
          ; If the command is 'reset, take the cdr of the reset stream. Otherwise, request-stream stays the same 
          (request-stream (if (eq? 'reset (car req)) 
                              (stream-cdr request-stream) 
                              request-stream))) 
      (define random-numbers
        ; Random numbers is a stream consisting of the random-init value plus...
        (cons-stream random-init
                     ; A mapping function that takes in a req and rnum 
                     (stream-map 
                      (lambda (req rnum) 
                        (cond
                          ; If the req is 'generate, return the invocation of rand-update on rnum
                          ((eq? 'generate (car req)) 
                           (rand-update rnum))
                          ; If the req is 'reset, return the reset value
                          ((eq? 'reset (car req)) 
                           (cadr req))
                          ; Else return an error
                          (else (error "Wrong request -- RAND" req)))) 
                      request-stream random-numbers))) 
      random-numbers)))

#| Testing |#

 (define s1 (rand (cons-stream '(reset 2010) 
                  (cons-stream '(generate) 
                  (cons-stream '(generate) 
                  (cons-stream '(generate) 
                  (cons-stream '(reset 2020) 
                  (cons-stream '(generate) 
                  (cons-stream '(generate) 
                  (cons-stream '(generate) 
                  (cons-stream '(reset 2020) integers)))))))))))

(display-n-terms s1 5)


