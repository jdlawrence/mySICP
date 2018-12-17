#lang racket
(define (reverse aList)
  (if (null? aList)
      aList
      (append (reverse (cdr aList)) (list (car aList)))))

#| Testing |#
(define jamil (list 1 2 3 4))
(define emptyList (cdr (list 1)))

(reverse jamil)
(reverse emptyList)
