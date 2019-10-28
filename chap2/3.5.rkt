#lang sicp
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (square n)
  (* n n))

(define (inside-circle cx cy r x1 y1)
  (< (+ (square (- cx x1)) (square (- cy y1)))
      (square r)))
  
(define (predicate cx cy r x1 x2 y1 y2)
  (inside-circle cx cy r (random-in-range x1 x2) (random-in-range y1 y2)))

(define (monte-carlo trials experiment)
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

#| Answer |#
(define (ex1) (predicate 0 0 1.0 -1.0 1.0 -1.0 1.0))

#| Pi !!!! |#
(* 4 (monte-carlo 1000000 ex1))
  