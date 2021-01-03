#lang sicp
(define (run-forever) (run-forever))
(define (try p)
(if (halts? p p) (run-forever) 'halted))

#| Answer:
"Try" returns the opposite of what you'd expect. If the predicate (halts? p p) in the try returns true, we
return (run-forever), which goes against the definition of halts. If the predicate returns false, meaning
the procedure does not halt and runs forever, we return 'halted', which is just a string. This meets the definition
of halting, and so once again, we have violated our definition.
|#





