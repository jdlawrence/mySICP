#lang sicp
; Here's my definition of reverse from exercise 2.18
(define (reverse aList)
  (if (null? aList)
      aList
      (append (reverse (cdr aList)) (list (car aList)))))

; The reverse of an empty list is an empty list
(reverse () ())

; If you can:
; - Append the car (first) to the cdr (rest) and it's equal to ?x
; - Append the reverse of the cdr (rev-rest) to first and it's equal to ?y
; - You can recursively call reverse with the cdr and the reverse of the cdr
(rule (reverse ?x ?y) 
      (and (append-to-form (?first) ?rest ?x) 
           (append-to-form ?rev-rest (?first) ?y) 
           (reverse ?rest ?rev-rest)))

#| NOTE: This works with (reverse? ?x (1 2 3)) but (reverse (1 2 3) ?x) causes
an infinite loop. |#

      

; Demonstrating the three rules
(append-to-form (1) (2 3) (1 2 3))
(append-to-form (3 2) (1) (3 2 1))
(reverse (2 3) (3 2))

