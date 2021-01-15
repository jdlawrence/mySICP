#lang sicp
#| Answer:
We need to change a couple of things:

The old text-quotation-just returned the element that came after the word 'quote:
(define (text-of-quotation exp) (cadr exp))

We now need it, if the text is a pair like in the example, (car '(a b c)), to make a
list out of the elements.
|#
(define (text-of-quotation exp env)
  (let ((text (cadr exp)))
    (if (pair? text)
        (eval (make-lazy-list text) env)
        text)))

; Here's the definition of make-lazy-list
(define (make-lazy-list text)
  (if (null? text)
      '()
      (list 'cons
            (list 'quote (car text))
            (make-lazy-list (cdr text)))))

; Finally, since we are passing lazy list to eval with an env, we need to change the
; arguments to text-of-quotation to include the env.
((quoted? exp) (text-of-quotation exp env))
