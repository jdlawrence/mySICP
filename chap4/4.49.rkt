#lang sicp
(define adjectives '(adjective hungry turquoised poignant ridiculous))

#|  We need to alter parse-word |#

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list (car word-list) found-word)))

#| What's notable is that if you give this function a simple-noun-phrase, it will output a simple noun phrase.
If you give it something more complex, it will output a sentence of the same complexity.
|#