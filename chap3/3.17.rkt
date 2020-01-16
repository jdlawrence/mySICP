#lang sicp
(define (count-pairs x)

#| Answer:
Have one function that goes through all of the pairs in any structure
Have another function that can check if a given pair is in a list
If the pair is in the list, keep going. If it's not in the list, append
or set-cdr! it to the end. Return the length of the list when you have
reached the end of the structure
|#



#| Testing |#
(define 1-pair (cons 'a 'b))
(define intermediate-2 (cons 1-pair 1-pair))
(define 3-pair-three (cons 'a (cons 'b (cons 'c '()))))
(define 4-pair-three (cons 'a intermediate-2))
(define 7-pair-three (cons intermediate-2 intermediate-2))
                                                   
(count-pairs 1-pair)
(count-pairs intermediate-2)
(count-pairs 3-pair-three)
(count-pairs 4-pair-three)
(count-pairs 7-pair-three)

