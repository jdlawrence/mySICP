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


|#
