#lang racket
(define (make-monitored f)
  ;(let ((count 0))
    (define count 0)
    (lambda (arg)
      (cond ((eq? arg 'how-many-calls) count)
            ((eq? arg 'reset-count) (set! count 0) count)
            (else 
             (set! count (+ count 1))
             (f arg)
             ))))

#| Answer |#
(define (left-right-diff)
  (define count -1)
  (lambda (arg)
    (set! count (+ count 1))
    (if (= count 0)
        (if (= arg 1)
            1
            0)
        0)
  ))
  

#| Testing |#
(define f (left-right-diff))
;(f 0)
(f 1)
(f 0)