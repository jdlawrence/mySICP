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
|#
(define (parse-verb-phrase)
  (amb (parse-word verbs)
       (list 'verb-phrase
             (parse-verb-phrase)
             (parse-prepositional-phrase))))