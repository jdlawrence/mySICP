#lang sicp
#| Answer:
I'm not sure exactly, but I believe this is saying that instead of listing all of the floors for each person,
ie:

(let ((baker (amb 1 2 3 4 5)) (cooper (amb 1 2 3 4 5))
(fletcher (amb 1 2 3 4 5)) (miller (amb 1 2 3 4 5))
(smith (amb 1 2 3 4 5)))

we should cut down this list to floors that are possible from the clues that are given. For example, since
cooper cannot be on floor 1, we can cut that list down to:

(cooper (amb 2 3 4 5))
|#

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct?  (cdr items)))))

(distinct? (list 'baker 'baker 'cooper 'fletcher 'miller 'smith))


(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4))
        (cooper (amb 2 3 4))
        (fletcher (amb 2 3 4))
        (miller (amb 3 4 5))
        (smith (amb 1 2 3 4 5)))
    (require
      (distinct? (list baker cooper fletcher miller smith)))
    #|
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    |# ; Removed because they are isolated conditions that can adjust for in the list for each person
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker) (list 'cooper cooper)
          (list 'fletcher fletcher) (list 'miller miller)
          (list 'smith smith))))

