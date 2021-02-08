#lang sicp
;When Alyssa makes the query
(lives-near ?person-1 ?person-2)

;she notices that each pair of people who live near each
;other is listed twice; for example,
(lives-near (Hacker Alyssa P) (Fect Cy D))
(lives-near (Fect Cy D) (Hacker Alyssa P))

#| This happens because both of these conditions satisfy the rule.
To get around this rule, we can apply a lisp value that will
eliminate results not sorted how we specify, ie if we sort in
ascending order, the first result will be eliminated since
(Hacker Alyssa P) comes after (Fect Cy D).

We need to do some symbol/string manipulation for this. Our
procedure is:
- Map symbol->string to change the names, which are symbols, to strings,
ie 'jamil -> "jamil"
- Using foldr and string-append, combine the person's entire from a list
ie '("jamil" "d" "lawrence") -> "jamildlawrence"
- We also have to change from a symbol to a string with string->symbol, ie
'(j a m i l) -> "jamil"

|#

; How is lives-near defined originally?
(rule (lives-near ?person-1 ?person-2)
      (and (address ?person-1 (?town . ?rest-1))
           (address ?person-2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2)))
      )


; NOTE: this doesn't work in the current evaluator because it doesn't recognize
; "string-append", "map", and "foldr".
(rule (lives-near-2 ?person1 ?person2) 
      (and (address ?person1 (?town . ?rest-1)) 
           (address ?person2 (?town . ?rest-2))
           (not (same ?person-1 ?person-2))
           (lisp-value (lambda (p1 p2)
                         (define (list->string symbol)
                           (foldr
                            string-append
                            ""
                            (map symbol->string symbol)))
                         (string<? (list->string s1) (list->string s2))))))
    


           