#lang racket
(define (make-mobile left right)
  (cons left right))

(define (make-branch length structure)
  (cons length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cdr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cdr branch))

(define (total-weight mobile)
  (define (weight-sub aBranch)
    (if (pair? (branch-structure aBranch))
        (total-weight (branch-structure aBranch))
        (branch-structure aBranch)))
  (+ (weight-sub (left-branch mobile))
     (weight-sub (right-branch mobile))))

(define branch1 (make-branch 1 2))
(define branch2 (make-branch 3 4))
(define mobile1 (make-mobile branch1 branch2))
(define mobile3 (make-mobile branch1 (make-branch 3 (make-mobile (make-branch 5 6) (make-branch 7 8)))))
;mobile1
;mobile3
;(left-branch mobile1)
;(pair? (branch-structure mobile3))
;(left-branch mobile3)
;(right-branch mobile1)
;(right-branch mobile3)

(total-weight mobile3)

