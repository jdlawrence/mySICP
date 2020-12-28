#lang racket
(define ns (make-base-namespace))
  
#| Given |#
(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

#| Answer: |#
(define (named-let exp) (symbol? (cadr exp)))

(define (let-body exp)
  (if (named-let exp)
      (cadddr exp)
      (caddr exp)))

(define (let-bindings exp)
  (if (named-let exp)
      (caddr exp)
      (cadr exp)))

(define (let-vars exp)
  (cadr exp))

(define (firsts aList)
  (if (empty? aList)
      aList
      (cons (caar aList) (firsts (cdr aList)))))

(define (seconds aList)
  (if (empty? aList)
      aList
      (cons (cadar aList) (seconds (cdr aList)))))

(define (make-named-lambda func parameters body)
  (list
   'define (cons func parameters) body))

(define (let->combination exp)
  (let (
        (bindings (let-bindings exp))
        (body (let-body exp))
        )
    (if (named-let exp)
        (let ((vars (let-vars exp)))
          (make-named-lambda vars (firsts bindings) body))
        (list (make-lambda (firsts bindings) (list body))
              (seconds bindings)))))

#| Testing |#
(define aLambda
  '(let (
         (x 3)
         (y 5)
         )
     (* x y 8)))

(define aLetLambda
  '(let fib-iter (
                 (a 1)
                 (b 0)
                 (count n)
                )
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  )

(define (fib n)
  (let fib-iter (
                 (a 1)
                 (b 0)
                 (count n)
                )
    (if (= count 0)
        b
        (begin (display b) (display "\n") (fib-iter (+ a b) a (- count 1))))
    ))

;(ex)

;(fib 20)
(define dummy (list '(1 2) '(3 4) '(5 6) '(7 8)))
(define dummy2 (cons '(1 2) (cons '(3 4) (cons '(5 6) (cons '(7 8) '())))))
;(firsts dummy)
;(firsts dummy2)
;(seconds dummy)

(let->combination aLambda)
(let->combination aLetLambda)
(eval '(+ 2 3) ns)
((lambda (x y) (* x y 8)) 3 5)
(define (fib-iter a b count) (if (= count 0) b (fib-iter (+ a b) a (- count 1))))

(fib-iter 1 0 15) 