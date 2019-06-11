#lang racket
#| Given |#
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1 (intersection-set (cdr set1)
                                          (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))

#| Answer |#

#| First attempt with sub routine |#
(define (union-set set1 set2)
  (define (sub s1 s2 result)
    (cond ((and (null? s1) (null? s2)) result)
          ((null? s1)
           (if (element-of-set? (car s2) result)
               (sub s1 (cdr s2) result)
               (sub s1 (cdr s2) (cons (car s2) result))))
          ((null? s2)
           (if (element-of-set? (car s1) result)
               (sub (cdr s1) s2 result)
               (sub (cdr s1) s2 (cons (car s1) result))))
          (else 
          (if (element-of-set? (car s1) result)
               (sub (cdr s1) s2 result)
               (sub (cdr s1) s2 (cons (car s1) result))))))
  (sub set1 set2 '()))

#| Second attempt with no subroutine |#
(define (union-set2 set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2) (union-set2 (cdr set1) set2))
        (else (cons (car set1) (union-set2 (cdr set1) set2)))))


(define s1 (list 1 2 3))
(define s2 (list 3 4 5))

(union-set s1 s2)
(union-set2 s1 s2)

