#lang sicp

#| Part a |#

#|
Peter: (set! balance (+ balance 10))
Paul: (set! balance (- balance 20))
Mary: (set! balance (- balance (/ balance 2)))
|#


#|
Let's note order like this: (Peter, Paul, Mary) means Peter then Paul then Mary

Starting with $100:

(Peter, Paul, Mary) = $45
(Peter, Mary, Paul) = $35
(Paul, Peter, Mary) = $45
(Paul, Mary, Peter) = $50
(Mary, Peter, Paul) = $40
(Mary, Paul, Peter) = $40
|#

#| Part b: See .jpg file for diagram. Possible values are $110, $80, and $50 |#

