#lang sicp
; Example:
(rule (outranked-by ?staff-person ?boss)
      (or (supervisor ?staff-person ?boss)
          (and (supervisor ?staff-person ?middle-manager)
               (outranked-by ?middle-manager ?boss))))

#|
says that a staff person is outranked by a boss in the organization if the
boss is the person’s supervisor or (recursively) if the person’s supervisor
is outranked by the boss.
|#

#|
Exercise 4.57:
Define a rule that says that person 1 can replace person 2 if either person 1 does the same job as person
2 or someone who does person 1’s job can also do person 2’s
job, and if person 1 and person 2 are not the same person.
Using your rule, give queries that find the following:

a. all people who can replace Cy D. Fect;
b. all people who can replace someone who is being paid
more than they are, together with the two salaries.
|#

#| Answer part A) |#
; Helper functions:
; person1 can replace person2 if they have the same job
(rule (same-job ?person1 ?person2)
      (and (job ?person1 ?job1)
           (job ?person2 ?job2)
           (same ?job1 ?job2)))

; person1 can do person2's job if (can-do-job) for both their respective jobs is true
(rule (person-can-do-job ?person1 ?person2)
      (and (job ?person1 ?job1)
           (job ?person2 ?job2)
           (can-do-job ?job1 ?job2)))

; Definition for replace
(rule (replace ?person1 ?person2)
      (and
       (or
        (same-job ?person1 ?person2)
        (person-can-do-job ?person1 ?person2)
        )
       (not (same ?person1 ?person2))))

#| Ben and Alyssa can replace Cy D Fect.|#
(replace ?person (Fect Cy D))

;returns:

(replace (Bitdiddle Ben) (Fect Cy D))
(replace (Hacker Alyssa P) (Fect Cy D))


#| Answer part B)|#

; Rule for returning people who a person who can replace another person
(rule (replace-higher-paid ?person1 ?person2)
      (and (salary ?person1 ?salary1)
           (salary ?person2 ?salary2)
           (lisp-value < ?salary1 ?salary2)
           (replace ?person1 ?person2)))

; Query to find all
(and (replace-higher-paid ?p1 ?p2) (salary ?p1 ?salary1) (salary ?p2 ?salary2))
;returns:
(and (replace-higher-paid (Aull DeWitt) (Warbucks Oliver)) (salary (Aull DeWitt) 25000) (salary (Warbucks Oliver) 150000))
(and (replace-higher-paid (Fect Cy D) (Hacker Alyssa P)) (salary (Fect Cy D) 35000) (salary (Hacker Alyssa P) 40000))


