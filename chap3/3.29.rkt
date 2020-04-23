#lang sicp
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))

(define (logical-and a1 a2)
  (if (and (= a1 1) (= a2 1))
      1
      0))

(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let (
          (i1 (logical-not (get-signal o1)))
          (i2 (logical-not (get-signal o2)))
          (and-output (logical-and i1 i2))
          (new-value  (logical-not and-output))
          )
      (after-delay
       (+ (* 3 inverter-delay) and-gate-delay)
       (lambda () (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)

#| More concise version below that uses prior definitions |#

(define (or-gate a1 a2 output) 
  (let ((c1 (make-wire)) 
        (c2 (make-wire)) 
        (c3 (make-wire))) 
    (inverter a1 c1) 
    (inverter a2 c2) 
    (and-gate c1 c2 c3) 
    (inverter c3 output))) 

