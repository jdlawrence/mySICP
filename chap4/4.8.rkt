#lang racket

#| Given |#
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

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
(define (let-body exp) (caddr exp))
(define (let-bindings exp) (cadr exp))

(define (firsts aList)
  (if (empty? aList)
      aList
      (cons (caar aList) (firsts (cdr aList)))))

(define (seconds aList)
  (if (empty? aList)
      aList
      (cons (cadar aList) (seconds (cdr aList)))))

(define (let->combination exp)
  (let (
        (bindings (let-bindings exp))
        (body (let-body exp))
        )
    (list (make-lambda (firsts bindings) (list body))
          (seconds bindings))))

#| Testing |#
(define aLambda
  '(let (
         (x 3)
         (y 5)
         )
     (* x y 8)))
 
(define dummy (list '(1 2) '(3 4) '(5 6) '(7 8)))
(define dummy2 (cons '(1 2) (cons '(3 4) (cons '(5 6) (cons '(7 8) '())))))
(firsts dummy)
(firsts dummy2)
(seconds dummy)

(let->combination aLambda)
((lambda (x y) (* x y 8)) 3 5)