#lang racket
(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

(define (total-weight mobile)
  (define (weight-sub aBranch)
    (if (pair? (branch-structure aBranch))
        (total-weight (branch-structure aBranch))
        (branch-structure aBranch)))
  (+ (weight-sub (left-branch mobile))
     (weight-sub (right-branch mobile))))

(define (torque branch)
    (if (pair? (branch-structure branch))
        (* (branch-length branch) (total-weight (branch-structure branch)))
        (* (branch-length branch) (branch-structure branch))))

(define (balanced? mobile)
  (and (= (torque (left-branch mobile)) (torque (right-branch mobile)))
       (if (pair? (branch-structure (left-branch mobile)))
           (balanced? (branch-structure (left-branch mobile)))
           #t)
       (if (pair? (branch-structure (right-branch mobile)))
           (balanced? (branch-structure (right-branch mobile)))
           #t)
       ))

(define branch1 (make-branch 3 8))

;(define branch2 (make-branch 4 6))

;(define branch3 (make-branch 6 (make-mobile (make-branch 2 11) (make-branch 7 13))))

(define branch4 (make-branch 2 (make-mobile (make-branch 2 6) (make-branch 2 6))))

;(define mobile1 (make-mobile branch1 branch2))

(define mobile2 (make-mobile branch1 branch4))


;mobile1
;(branch-length (make-branch 3 5))
;(pair? (branch-structure (make-branch 3 5)))
;(pair? (branch-structure (make-branch 3 (make-mobile (make-branch 2 11) (make-branch 7 13)))))
;(right-branch mobile1)
;(total-weight mobile1)

;(total-weight mobile2)
;(torque branch3)
(torque branch4)
(balanced? mobile2)
;mobile2
