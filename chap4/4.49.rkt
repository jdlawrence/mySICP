#lang sicp
(define adjectives '(adjective hungry turquoised poignant ridiculous))

#|  We need to alter parse-word

We take 

(list (car word-list) found-word)))

which adds the part of speech (noun-phrase, adjective, noun, etc)

and replace it with

(list-amb (cdr word-list))))

which adds ignores the input (found-word) and just goes through all of the choices in
word-list, which is either all of the adjectives, nouns, pronouns, etc.

To iterate with amb through the list of words that we have, we can use the given
an-element-of, or we can use list-amb, defined below as well.
|#

(define (an-element-of items)
(require (not (null? items)))
(amb (car items) (an-element-of (cdr items))))

(define (list-amb lst)
    (if (null? lst)
        (amb)
        (amb (car lst) (list-amb (cdr lst)))))

(define (parse-word word-list)
  (require (not (null? *unparsed*)))
  (require (memq (car *unparsed*) (cdr word-list)))
  (let ((found-word (car *unparsed*)))
    (set! *unparsed* (cdr *unparsed*))
    (list-amb (cdr word-list))))
;   (an-element-of (cdr word-list))))

#| What's notable is that if you give this function a simple-noun-phrase, it will output a simple noun phrase.
If you give it something more complex, it will output a sentence of the same complexity.

|#