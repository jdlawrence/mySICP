#lang sicp
#|

1. all people supervised by Ben Bitdiddle;
(supervisor ?x (Ben Bitdiddle))

2. the names and jobs of all people in the accounting division;
(?x ?y (accounting ?z))

3. the names and addresses of all people who live in Slumerville.
(?x ?y (Slumerville ?z ?w))

|#
(if (not (true? pred-value)) 
    (fail) 
    (succeed 'ok fail2)) 
