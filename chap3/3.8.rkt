#lang racket
#| Answer |#
(define (left-right-diff)
  (define count -1)
  (lambda (arg)
    (set! count (+ count 1))
    (if (= count 0)
        arg
        0)))
  

#| Testing |#
(define f (left-right-diff))
;(+ (f 0) (f 1)) returns 0
(+ (f 1) (f 0)) ;returns 1 (When it's the only function executed)