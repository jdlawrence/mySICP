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
(define z (make-complex-from-real-imag 3 4))

we first call (apply-generic 'magnitude z). Inside apply-generic, we have (map type-tag args).
This applies the 'complex tag to the z argument.
We also have (get op type-tags), which is (get 'magnitude (complex))
Inside apply-generic is (apply proc (map contents args)) which simplifies to:
(apply (get 'magnitude (complex)) ('rectangular 3 4)))

(get 'magnitude complex) returns a magnitude function from the rectangular package, and the process
 begins once again. Inside the 'rectangular package, magnitude will eventually return:

(sqrt (+ (square (real-part z))
  (square (imag-part z)))))


This will evaluate the magnitude of z in rectangular, which will be 5.

Apply-generic is called twice, once for the complex tag, and once for the rectangular tag.


|#
