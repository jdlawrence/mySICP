#lang sicp
; Here's my definition of reverse from exercise 2.18
(define (reverse aList)
  (if (null? aList)
      aList
      (append (reverse (cdr aList)) (list (car aList)))))

#| Answer:
The basic operation would be to store a list of all the queries, and if a query has been conducted with
certain arguments already, then we assume there's a loop.

I'll leave the details of this alone for now.

|#

(rule (reverse (?orig) (?rev)))
(rule (reverse (?first . ?rest) ?rev)
      (append-to-form (reverse ?rest ?rev2) (?first)))
      
      
      