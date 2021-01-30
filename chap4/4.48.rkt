#lang sicp
(define adjectives '(adjective hungry turquoised poignant ridiculous))

#| To add to a noun phrase, we can make it another item in an amb list |#

; Original Simple-noun-phrase

(define (parse-simple-noun-phrase)
  (list 'simple-noun-phrase
        (parse-word articles)
        (parse-word nouns)))

; Extended with adjectives
(define (parse-simple-noun-phrase)       
  (amb (list 'simple-noun-phrase 
             (parse-word articles) 
             (parse-word nouns)) 
       (list 'simple-noun-phrase 
             (parse-word articles) 
             (parse-word adjectives) 
             (parse-word nouns))))