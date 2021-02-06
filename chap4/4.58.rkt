#lang sicp
#|
Define a rule that says that a person is a “big
shot” in a division if the person works in the division but
does not have a supervisor who works in the division.
|#

; Query the division of the person
; Query the person's boss
; Query the boss's division
; Check and see that the two divisions are not equal
(rule (big-shot ?person)
      (and
       (job ?person (?division . ?rest))
       (supervisor ?person ?boss)
       (job ?boss (?boss-division . ?boss-rest))
       (not (same ?division ?boss-division))))
