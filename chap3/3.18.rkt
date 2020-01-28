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
#| Due to the provided nature of how Racket implements a circular list
I cannot test these solutions. I tried to import mutable pairs, etc, but
still cannot test. I believe both my solution above and one I found online
below are applicable.
|#

(define (has-loop? lis) 
  (define (iter searchlist seen) 
    (cond ((not (pair? searchlist)) #f) 
          ((memq searchlist seen) #t) 
          (else (or (iter (car searchlist) (cons searchlist seen)) 
                    (iter (cdr searchlist) (cons searchlist seen)))))) 
  (iter lis '())) 

(cycle? z)
(cycle? def)
(has-loop? def)
  




