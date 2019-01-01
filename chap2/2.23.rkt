#lang racket
(for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

(define (my-for-each proc items)
  (if (null? items)
      #t
      (cons (proc (car items)) (my-for-each proc (cdr items)))))
       
(my-for-each (lambda (x) (newline) (display x))
          (list 57 321 88))

