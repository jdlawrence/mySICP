#lang racket
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (error
           "No method for these types: APPLY-GENERIC"
           (list op type-tags))))))

#| Answer:
Alyssa P Hacker's trick works because we are using a two level tag system. We first must determine
if we are using the scheme-number, rational, or complex packages. Once we have selected the complex
package, we can use functions inside of it, like real-part, imag-part, etc.

When the expression (magnitude z) is called with the expression in 2.24,
('complex 'rectangular 3 + 4i)

we first call (apply-generic 'magnitude z). Inside apply-generic, we have (map type-tag args). This
returns a list of tags, (list 'complex 'rectangular).  This will use "get" to look up a procedure that
corresponds with the tags, which will be
(sqrt (+ (square (real-part z))
  (square (imag-part z)))))

This will calculate use the complex package, rectangular definition of the magnitude function.
Apply-generic will only be called once.


|#
