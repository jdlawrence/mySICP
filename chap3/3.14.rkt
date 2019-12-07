#lang sicp
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

#| Testing |#
(define k (list 'a '()))
(cdr k)

(define v (list 'a 'b 'c 'd))

(define w (mystery v))

v
w


#| Answers: |#
#|
Mystery reverse a linked list. It does it through the following description:

- Start with full list and null
- Split list into first item and rest of items
- Attach first item and null
- Call function recursively with rest of items and (first-item + null)

|#
