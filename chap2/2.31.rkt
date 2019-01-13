#lang racket
(define (square x) (* x x))

(define (tree-map proc tree)
  (map (lambda (sub-tree)
       (if (pair? sub-tree)
           (tree-map proc sub-tree)
           (proc sub-tree)))
       tree))

(define (square-tree tree) (tree-map square tree))
 
#| Testing |# 
(define l1 (list 1 2 3 4))          
(define l2 (list 1 (list 2 3)))
(define l3 (list 1 (list 2 (list 3 4) 5) (list 6 7))) 
(square-tree l2)
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
(square-tree l3)
