#lang racket

(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (error "Bad tagged datum: CONTENTS" datum)))

#| Answer:
The exercise asks us to take advantage of the fact that primitives in Scheme already
have a tag built in, and so we don't need to add one. For the type-tag and
contents operations, this mean we'll see use a "cond" instead of an "if" to determine
how to handle the datum because we have three conditions:
1) The datum is a number. This means the type-tag is 'scheme-number and the contents
are just the number itself
2) The datum is a pair and not a number. This means the type-tag is whatever the tag
is (rational, complex, etc) and the contents are the "cdr" of the pair
3) The datum is neither a number nor a pair. Throw an error
|#
(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum: TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum: CONTENTS" datum))))

#| Answer:
For attach-tag, we have those three cases again, but we take different actions.
1) If the datum is a number, it already has a built in type-tag, so we just return the
number
2) If the datum is a pair, attach the type-tag with cons.
3) Else, throw an error
|#

(define (attach-tag type-tag datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cons type-tag datum))
        (else (error "Bad tagged datum: ATTACH-TAG" datum))))