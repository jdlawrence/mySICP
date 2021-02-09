#lang sicp

#|
Formulate rules such as “If S is the son of f , and f is the
son of G, then S is the grandson of G” and “If W is the wife
of M, and S is the son of W , then S is the son of M” (which
was supposedly more true in biblical times than today) that
will enable the query system to find the grandson of Cain;
the sons of Lamech; the grandsons of Methushael. (See Exercise 4.69 for some rules to deduce more complicated relationships.)
|#

(son Adam Cain)
(son Cain Enoch)
(son Enoch Irad)
(son Irad Mehujael)
(son Mehujael Methushael)
(son Methushael Lamech)
(wife Lamech Ada)
(son Ada Jabal)
(son Ada Jubal)

(rule (grandson ?gf ?gs)
      (and (son ?gf ?father)
           (son ?father ?gs)))

(rule (son ?f ?s)
      (and (wife ?f ?wife)
           (son ?wife ?s)))

; *** Answers ***
;;; Query input:
(grandson Cain ?x)

;;; Query results:
(grandson Cain Irad) ; Irad is the grandson of Cain

;;; Query input:
(son Lamech ?x)

;;; Query results:
(son Lamech Jubal) ; Jubal is one son of Lamech
(son Lamech Jabal) ; Jabal is another son of Lamech

;;; Query input:
(grandson Methushael ?x)

;;; Query results:
(grandson Methushael Jubal) ; Jubal is one grandson of Methushael
(grandson Methushael Jabal) ; Jabal is another grandson of Methushael


