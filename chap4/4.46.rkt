#lang sicp
#|
We need to parse from left to right because we read from left to right in English.
Our word order mandates this. Also, the "parse" function is designed to work from
left to right.
|#

(define *unparsed* '())
(define (parse input)
  (set! *unparsed* input)
  (let ((sent (parse-sentence)))
    (require (null? *unparsed*)) sent))
