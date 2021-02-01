#lang sicp

#| Consider list-ref |#

(define (remove-at-index aList index)
  (define (iter front back curr)
    (if (= curr index)
        (append front (cdr back))
        (iter (append front (list (car back))) (cdr back) (+ curr 1))))
  (iter '() aList 0))

#| Answer:

This would helps with Alyssa's problem of generating random sentences because the parts of speech
used to create each portion would not be ordered in the way they were defined, and the sentences
would seem more natural.

|#
(define (ramb aList)
  (let ((rIndex (random (length aList))))
  (amb (list-ref aList rIndex) (ramb (remove-at-index aList rIndex)))))


#| Testing |#
(list (amb 1 2 3) (amb 'a 'b 'c))
(ramb '(1 2 3 4))

(remove-at-index '(0 1 2 3 4 5) 0)
(remove-at-index '(0 1 2 3 4 5) 1)
(remove-at-index '(0 1 2 3 4 5) 3)
(remove-at-index '(0 1 2 3 4 5) 5)
;(remove-at-index '(0 1 2 3 4 5) 7)

