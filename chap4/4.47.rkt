#lang sicp
(define (parse-verb-phrase)
  (define (maybe-extend verb-phrase)
    (amb verb-phrase
         (maybe-extend
          (list 'verb-phrase
                verb-phrase
                (parse-prepositional-phrase)))))
  (maybe-extend (parse-word verbs)))

#|
Louis Reasoner's implementation below assumes that there MUST be a prepositional phrase
in the verb phrase. If there isn't one, his implementation will break. The given one (above)
does not assume that and surrounds the part with the prepositional phrase in a "maybe-extend".

We cannot change the order of the expressions in the "amb" portion. If we do and we put
(parse-verb-phrase) first, amb will choose it first, and get stuck in an infinite loop because
it keeps calling itself.
|#
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))