#lang racket
;gabrielle 1
;lorna 2
;maryann 3
;melissa 4
;rosalind 5
(define (yachts)
    (let ((downing (amb 1 2 5))
          (hall (amb 1 2))
          (hood 4)
          (moore 3)
          (parker (amb 1 2 5)))
      (require
        (distinct? (list downing hall hood moore parker)))
      (require (cond
                 ((= hall 1) (= parker 5))
                 ((= downing 1) (= parker 4))
                 (else false)))
      (list
       (list 'downing downing)
       (list 'hall hall)
       (list 'hood hood)
       (list 'moore moore)
       (list 'parker parker))))
;(yachts) outputs ((downing 2) (hall 1) (hood 4) (moore 3) (parker 5)), so Downing is Lorna's father

#|
If we don't know that Maryann's last name is Moore, we have two possibilities
((downing 2) (hall 1) (hood 3) (moore 4) (parker 5))
and
((downing 5) (hall 3) (hood 4) (moore 1) (parker 2))
downing-rosalind hall-maryann hood-melissa moore-gabrielle parker-lorna
|#