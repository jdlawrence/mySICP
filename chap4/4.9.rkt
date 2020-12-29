#lang racket
(define ns (make-base-namespace))

#| Answer:

"do" is a construct that forces the code to execute at least once. After the
first execution, before each subsequent execution, it evaluates a predicate,
and if the predicate is true, it will continue to execute the code block. If
the predicate is continuously true, the "do" block will execute infinitely.
It's also known as "do while".

"while" is a construct for repeatedly executing an action as long a predicate
is true. Similar to "do" or "do while" but the difference is that if predicate
is never true, the code block will never execute at all.

"for" is a construct to execute a code block a predetermined number of times. In
Racket, this is accomplished in a recursive manner and the traditional concept
of a for loop doesn't exist.

"until" is a construct use for repeating an action as long as a predicate is false.
It is nearly the same as a "while" loop except that a "while" loop is executed when the
predicate is true, and an "until" loop is executed while the predicate is false. 

|#
