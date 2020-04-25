#lang sicp

#| NOTE: this expects the a-list and b-list to be reversed before being inputted |#
(define (ripple-carry-adder a-list b-list s-list c-in)
  (if (null? a-list) (cons s-list c-in)
      (let (
            (a (car a-list))
            (b (car b-list))
            (s (make-wire))
            (c-out (make-wire))
            )
        (full-adder a b c-in s c-out)
        (ripple-carry-adder (cdr a-list) (cdr b-list) (cons s s-list) c-out))))

#| Alternative solution that doesn't require input bits to be reverse |#
(define (ripple-carry-adder a b s c) 
  (let ((c-in (make-wire))) 
    (if (null? (cdr a)) 
        (set-signal! c-in 0) 
        (ripple-carry-adder (cdr a) (cdr b) (cdr s) c-in)) 
    (full-adder (car a) (car b) c-in (car s) c))) 


#| The time delay for this is:

  n * 2 * (or-gate-delay + 2 * and-gate-delay + inverter-gate-delay)

where n is the number of bits. We need 2 half adders to make the full adder,
and each half adder has one or-gate, 2 and-gates, and one-inverter.

|#


            

