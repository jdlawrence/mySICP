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

(tree->list-1 7-t)
(tree->list-2 7-t)