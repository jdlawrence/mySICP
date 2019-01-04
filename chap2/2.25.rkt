#lang racket
#| 1st Answer
(1 3 (5 7) 9)
cdr, cdr, car, cdr, car
|#
(list 1 3 (list 5 7) 9)
(car (cdr (car (cdr (cdr (list 1 3 (list 5 7) 9))))))


#| 2nd Answer
((7))
car, car, car
|#

(list (list 7))
(car (car (list (list 7))))

#| 3rd Answer
(1 (2 (3 (4 (5 (6 7))))))
cdr, cdr, cdr, car, cdr, car, cdr, car, cdr, car, cdr, car
|#

(list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))
(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr
                                    (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7))))))
                                    ))))))))))))