#lang sicp

(define (logical-or o1 o2)
  (cond
    ((and (= o1 0) (= o2 0)) 0)
    ((and (= o1 0) (= o2 1)) 1)
    ((and (= o1 1) (= o2 0)) 1)
    ((and (= o1 1) (= o2 1)) 1)
        (else (error "Invalid signal" o1 o2))))

(logical-or 0 0)
(logical-or 0 1)
(logical-or 1 0)
(logical-or 1 1)
(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal o1) (get-signal o2))))
      (after-delay
       or-gate-delay
       (lambda () (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
  'ok)

