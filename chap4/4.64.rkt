#lang sicp
; Original outranked-by
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person ?middle-manager)
               (outranked-by ?middle-manager ?boss))))

; Louis Reasoner's version
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (outranked-by ?middle-manager ?boss) ; Problematic line
               (supervisor ?staff-person
                           ?middle-manager))))


#| Answer:
The problematic line, (outranked-by ?middle-manager ?boss), introduced an unbound
variable in our query system. ?middle-manager could be anyone. When we recursively call
outranked-by again, it will be introduce another unbound variable, ?middle-manager once
again. This who happen over and over, and hence we get the infinite loop.
|#