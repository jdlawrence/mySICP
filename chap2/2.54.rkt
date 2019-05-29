#lang racket


#| Answer |#
(define (equal? a b)
  (cond ((and (pair? a) (pair? b))
         (and (equal? (car a) (car b))
              (equal? (cdr a) (cdr b))))
        ((and (not (pair? a)) (not (pair? b)))
         (eq? a b))
        (else #f)))

#| Testing |#
(eq? 'a (cons 'a 'b))
(equal? '(this is a list) '(this is a list))
(eq? '(this is a list) '(this (is a) list))
(equal? '(this is a list) '(this (is a) list))
(equal? '(a '(b c) '(d '(e f))) '(a '(b c) '(d '(e f))))