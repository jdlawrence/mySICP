#lang sicp
; The wheel rule is defined as:
(rule (wheel ?person)
      (and (supervisor ?middle-manager ?person)
           (supervisor ?x ?middle-manager)))
; It defines a wheel as someone who supervises a middle-manager, and that middle-manager in turn
; supervises someone else. 

; If we put in the query (and (supervisor ?middle-manager ?person) (supervisor ?x ?middle-manager))
; without the wheel rule, we get:
(and (supervisor (Scrooge Eben) (Warbucks Oliver)) (supervisor (Cratchet Robert) (Scrooge Eben)))
(and (supervisor (Bitdiddle Ben) (Warbucks Oliver)) (supervisor (Tweakit Lem E) (Bitdiddle Ben)))
(and (supervisor (Hacker Alyssa P) (Bitdiddle Ben)) (supervisor (Reasoner Louis) (Hacker Alyssa P)))
(and (supervisor (Bitdiddle Ben) (Warbucks Oliver)) (supervisor (Fect Cy D) (Bitdiddle Ben)))
(and (supervisor (Bitdiddle Ben) (Warbucks Oliver)) (supervisor (Hacker Alyssa P) (Bitdiddle Ben)))

; (Warbucks Oliver) appears 4 times because he meets the rule in 4 different ways:
; Warbucks Oliver -> Scrooge Eben -> Cratchet Robert
; Warbucks Oliver -> Bitdiddle Ben -> Tweakit Lem E
; Warbucks Oliver -> Bitdiddle Ben -> Fect Cy D
; Warbucks Oliver -> Bitdiddle Ben -> Hacker Alyssa P

; The query system is written such that it explores all of the possible ways a rule can be met. 