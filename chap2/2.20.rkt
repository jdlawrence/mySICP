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

#| Alternative version that doesn't need that "Append" helper |#
(define (same-parity2 . args)
  (define (sub aList parity)
       (cond ((null? aList) '()) ; Note that you must use '() if using #lang racket and not #lang sicp
             ((parity (car aList)) (cons (car aList) (sub (cdr aList) parity)))
          (else (sub (cdr aList) parity))))
  (if (even? (car args))
      (sub args even?)
      (sub args odd?)))

(define (map proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (mapDivideBy3 items)
  (map (lambda (x) (/ x 3)) items))

#| Testing |#
(filter-odd (list 1 2 3 4 5 6) (list)) ; '(1 3 5)
(filter-even (list 1 2 3 4 5 6) (list)) ; '(2 4 6)
(same-parity 1 2 3 4 5 6 7) ; '(1 3 5 7)
(same-parity 2 3 4 5 6 7) ; '(2 4 6)
(same-parity2 2 3 4 5 6 7 8 9 10 11 12) ; '(2 4 6 8 10 12)
(mapDivideBy3 (list 3 6 9 12 15 18)) ; '(1 2 3 4 5 6)
