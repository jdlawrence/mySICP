#lang racket
#| Given |#
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
               (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                   (partial-tree
                    (cdr non-left-elts)
                    right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                     (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

#| Testing |# 
;(list->tree (list 1 2 3))
;(list->tree (list 1 3 5 7 9 11 13 15 17 19 21 23 25))
(list->tree (list 1 2 3 4 5 6 7 8))
;(list->tree (list 1 2 3 4 5 6 7 8 9 10 11 12 13))
;'(4 (2 (1 () ()) (3 () ())) (6 (5 () ()) (7 () ())))

#| Answer
a)
- Calculate left-size, which will serve as n. This is half the number of elements divided by 2 (integer division).

- Using left-size as n, make a partial-tree from the first n elements. This will be the left result, and the "car"
of left-result is left-tree.

- The "car" of the non-left-elts will be "this-entry"

- Calculate the right-size from left-size + 1 - n.

- Using right-size as n, create a partial tree from the "cdr" of non-left-elts. This will be right-result, and the
"car" of right-result is right-tree.

- Call make-tree with this-entry, left-tree, and right-tree.

- Base case: If ever partial-tree is called with n = 0, return the empty list, '()

(list-tree '(1 3 5 7 9 11)) produces (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

b) The order of growth of this is linear, O(n)


|#
