#lang racket

(require rnrs/mutable-pairs-6)
(require compatibility/mlist)

(define (last-pair x)
  (if (null? (mcdr x)) x (last-pair (mcdr x))))

(define (make-cycle x)
  (set-mcdr! (last-pair x) x)
  x)

;(define abc '(a b c))
(define abc (mcons 'a (mcons 'b (mcons 'c '()))))
(define def (mcons 'd (mcons 'e (mcons 'f '()))))
(define z (make-cycle abc))
(define y (make-cycle def))

(define (count-pairs-2 x) 
  (let ((encountered '())) 
    (define (helper x) 
      (if (or (not (pair? x)) (memq x encountered)) 
          0 
          (begin 
            (set! encountered (cons x encountered)) 
            (+ (helper (car x)) 
               (helper (cdr x)) 
               1)))) 
    (helper x)))
(eq? (cdr (cons 'a '())) '())

(define (cycle? a-list)
  (let ((visited null))
    (define (sub x)
      (cond ((eq? (mcdr x) '()) #f)
            ((mmemq (mcar x) visited) #t)
            (else 
             (begin
               (set! visited (mcons (mcar x) visited))
               (sub (mcdr x))))))
      (sub a-list)))

(cycle? z)
(cycle? def)
  




