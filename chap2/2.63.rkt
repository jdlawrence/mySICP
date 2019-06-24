#lang racket
#| Given |#
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1
                     (right-branch tree))))))


(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list
                             (right-branch tree)
                             result-list)))))
  (copy-to-list tree '()))
      

#| Testing |# 
(define 1-t (make-tree 1 null null))
(define 5-t (make-tree 5 null null))
(define 11-t (make-tree 11 null null))
(define 3-t (make-tree 3 1-t 5-t))
(define 9-t (make-tree 9 null 11-t))
(define 7-t (make-tree 7 3-t 9-t))

(define 11-tb (make-tree 11 null null))
(define 9-tb (make-tree 9 null 11-tb))
(define 5-tb (make-tree 5 null null))
(define 7-tb (make-tree 7 5-tb 9-tb))
(define 1-tb (make-tree 1 null null))
(define 3-tb (make-tree 3 1-tb 7-tb))

(define 1-tc (make-tree 1 null null))
(define 7-tc (make-tree 7 null null))
(define 11-tc (make-tree 11 null null))
(define 3-tc (make-tree 3 1-tc null))
(define 9-tc (make-tree 9 7-tc 11-tc))
(define 5-tc (make-tree 5 3-tc 9-tc))

(tree->list-1 7-t)
(tree->list-2 7-t)

(tree->list-1 3-tb)
(tree->list-2 3-tb)

(tree->list-1 5-tc)
(tree->list-2 5-tc)

#| Answer: Part A |#
#|
Both functions produce the same lists.
For figure 2.16, the list is (list 1 3 5 7 9 11)
|#

#| Answer: Part B |#
#|
Tree->list-1 calls append for each iteration. Append is O(n), and
tree->list-1 visits each node once, so it is O(n^2) overall

Tree->list-2 uses an accumulator, and just visits each node once,
therefor it is O(n) overall
|#
