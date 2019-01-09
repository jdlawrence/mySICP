#lang racket
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define (total-weight mobile)
  (define (sub items result)
    (cond ((null? items) result)
          ((not (pair? (left-branch items))) (+ result ) )
          (else (append (sub (car items) result) (sub (cdr items) result)))))
  (sub mobile '())) 

(define x (list (list 1 2) (list 3 4)))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (fringe aList)
  (define (sub items result)
    (cond ((null? items) result)
          ((not (pair? items)) (append result (list items)))
          (else (append (sub (car items) result) (sub (cdr items) result)))))
  (sub aList '()))

(define test1 (list 1 2 3 4))

(fringe test1)
(fringe x)

(define branch1 (make-branch 3 5))

(define branch2 (make-branch 4 7))

(define mobile1 (make-mobile branch1 branch2))

mobile1
  