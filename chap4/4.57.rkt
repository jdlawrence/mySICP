#lang sicp
#|

|#
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person ?middle-manager)
               (outranked-by ?middle-manager ?boss))))
#|
says that a staff person is outranked by a boss in the organization if the
boss is the person’s supervisor or (recursively) if the person’s supervisor
is outranked by the boss.
|#