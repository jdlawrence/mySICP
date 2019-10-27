#lang racket
#| Answer |#
(define (make-monitored f)
  (let ((count 0))
    (lambda (arg)
      (cond ((eq? arg 'how-many-calls) count)
            ((eq? arg 'reset-count) (set! count 0))
            (else (begin
                    (set! count (+ count 1))
                    (f arg)
                    ))))))
#| Testing |#
(define (double n)
  (* 2 n))
 
  

(define m-double (make-monitored double))
(m-double 4)
(m-double 5)
(m-double 'how-many-calls)
(m-double 5)
(m-double 6)
(m-double 'how-many-calls)
(m-double 'reset-count)
(m-double 'how-many-calls)
(m-double 7)
(m-double 8)
(m-double 9)
(m-double 'how-many-calls)
   
               
                     