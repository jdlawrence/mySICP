#lang sicp
#|
Define a rule that says that a person is a “big
shot” in a division if the person works in the division but
does not have a supervisor who works in the division.
|#

; Query the division of the person
; Query to see to see if the person has a boss. If they don't, they're a big shot
; Query the person's boss
; Query the boss's division
; Check and see that the two divisions are not equal
(rule (big-shot ?person ?division)
      (and
       (job ?person (?division . ?rest))
       (or (not (supervisor ?person ?boss))
           (and  (supervisor ?person ?boss)
                 (job ?boss (?boss-division . ?boss-rest))
                 (not (same ?division ?boss-division))))))
