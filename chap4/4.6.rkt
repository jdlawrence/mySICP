#lang racket


(define (firsts aList)
  (if (empty? aList)
      aList
      (cons (caar aList) (firsts (cdr aList)))))

(define (seconds aList)
  (if (empty? aList)
      aList
      (cons (cadar aList) (seconds (cdr aList)))))
#| Problem Description:
(let ((⟨var1⟩ ⟨exp1⟩) . . . (⟨varn⟩ ⟨expn⟩))
⟨body⟩)

is equivalent to

((lambda (⟨var1⟩ . . . ⟨varn⟩)
⟨body⟩)
⟨exp1⟩
. . .
⟨expn⟩)

|#
#| Answer: |#
(define (let->combination exp)
  (cons (make-lambda (firsts (car exp)) (cddr exp))
        (seconds (car exp))))

#| Testing |#
(define dummy (list '(1 2) '(3 4) '(5 6) '(7 8)))
(define dummy2 (cons '(1 2) (cons '(3 4) (cons '(5 6) (cons '(7 8) '())))))
(firsts dummy)
(firsts dummy2)
(seconds dummy)
