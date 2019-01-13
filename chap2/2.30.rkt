#lang racket



#| Map already knows how to iterate over the elements in a tree |#
(define (scale-tree tree factor)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (scale-tree sub-tree factor)
             (* sub-tree factor)))
       tree))

(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* tree tree))
        (else (cons  (square-tree (car tree)) (square-tree (cdr tree))))))

(define (square-tree-map tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree-map sub-tree)
             (* sub-tree sub-tree)))
       tree))

#| Testing |#
(define l1 (list 1 2 3 4))          
(define l2 (list 1 (list 2 3)))
(define l3 (list 1 (list 2 (list 3 4) 5) (list 6 7))) 
(scale-tree l1 3)
(square-tree l2)
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
(square-tree l3)
(square-tree-map l3)