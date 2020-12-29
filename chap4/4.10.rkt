#lang racket
(define ns (make-base-namespace))

#| Prompt design and implement a new syntax for Scheme by modifying
the procedures in this section, without changing eval or apply.

Answer:

Let's say we have a new syntax that where the operator or procedures comes after the expression
instead of before, ie

(list 'jamil 'quote) instead of (list 'quote 'jamil)


Currently quotations have the form:
(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))

We need to change these. The first one, tagged-list, will now have to check if the last item in
the list is the tag:

(define (last_element l)
  (cond ((null? (cdr l)) (car l))
        (else (last_element (cdr l)))))

(define (tagged-list? exp tag)
  (if (pair? exp)
    (eq? (last-element exp) tag)
    false))

Also the "text-of-quotation" will be different because the text will be the first element and not
the second:

(define (text-of-quotation exp) (car exp))

This shows how "eval" and "apply" can stay the same because the implementation details of the
syntax is abstracted.

|#

(define (last-element l)
  (cond ((null? (cdr l)) (car l))
        (else (last-element (cdr l)))))

(last-element (list 1 2 3 4 5))

(list 'quote 'jamil)
