#lang racket

(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))

(define (filter-odd aList result)
  (if (null? aList)
      result
      (if (odd? (car aList))
          (filter-odd (cdr aList) (append result (list (car aList))))
          (filter-odd (cdr aList) result))))

(define (filter-even aList result)
  (if (null? aList)
      result
      (if (even? (car aList))
          (filter-even (cdr aList) (append result (list (car aList))))
          (filter-even (cdr aList) result))))

(define (same-parity . args)
  (if (odd? (car args))
      (filter-odd args (list))
      (filter-even args (list))))


#| Testing |#
(filter-odd (list 1 2 3 4 5 6) (list))
(filter-even (list 1 2 3 4 5 6) (list))
(same-parity 1 2 3 4 5 6 7)
(same-parity 2 3 4 5 6 7)