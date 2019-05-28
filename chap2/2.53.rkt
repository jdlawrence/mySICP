#lang racket
(define (memq item x)
  (cond ((null? x) false)
        ((eq? item (car x)) x)
        (else (memq item (cdr x)))))

#| Testing |#
;(memq 'b '(a b c d e))

;(define a 5)
;(define b 6)
;(define c 7)
;(define d 8)
;(list 1 2 3 4)
;(list a b c d)

;(define weird '(x (apple sauce) y apple pear))

;(cadr weird)

;(memq 'apple '(x (apple sauce) y apple pear)) ; Returns '(apple pear) because "(apple sauce)" is one string and it doesn't match "apple"

;(caddr (list 1 2 3 4 5 6 7 8))

#| Answer |#
(list 'a 'b 'c) ; '(a b c)
(list (list 'george)) ; '((george))
(cdr '((x1 x2) (y1 y2))) ; '((y1 y2)) NOTE: a nested list
(cadr '((x1 x2) (y1 y2))) ; '(y1 y2) NOTE: not a nested list. This picks the first element of the nested list in the previous exercse.
(pair? (car '(a short list))) ;#f
(memq 'red '((red shoes) (blue socks))) ; #f
(memq 'red '(red shoes blue socks)) ; '(red shoes blue socks)