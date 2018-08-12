#lang sicp
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
#|
NOTE: I'm using 'r' instead of 'remainder' for brevity.

In normal order:

Remember in normal order, you always keep expanding the procedure until you have only primitives
operands.

(gcd 206 40):
(if (= 40 0)
  206
  (gcd 40 (r 206 40)))

(gcd 40 (r 206 40))
(if (= (r 206 40) 0) ; (r 206 40) evaluates to 6. R1
    40
    (gcd (r 206 40) (r 40 (r 206 40))))

(gcd (r 206 40) (r 40 (r 206 40))):
(if (= (r 40 (r 206 40)) 0) ; (r 40 (r 206 40)) is evaluated to 4. R2 & R3.
    (r 206 40)
    (gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))

(gcd (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))):
(if (= (r (r 206 40) (r 40 (r 206 40))) 0) ; (r (r 206 40) (r 40 (r 206 40))) evaluates to 2. R4 to R7. 
    (r 40 (r 206 40))
    (gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))))

(gcd (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))))):
(if (= (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))) 0) ;
#|
(r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40))) evaluates to 0. R8 to R14
|#
   (r (r 206 40) (r 40 (r 206 40)))
   (gcd (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))) (r (r (r 206 40) (r 40 (r 206 40))) (r (r 40 (r 206 40)) (r (r 206 40) (r 40 (r 206 40)))))))

;The if statement is finally true, so we just need evaluate (r (r 206 40) (r 40 (r 206 40)))
(r (r 206 40) (r 40 (r 206 40))) ; This calls r 4 more times.  R15 to R18
(2)

R is called 18 times!
|#

#|

In applicative order:
GCD(206, 40): 206%40 = 6
GCD(40, 6): 40%6 = 4
GCD(6, 4): 6%4 = 2
GCD(4, 2): 4%2 = 0;
GCD(2, 0) => 2 is the GCD

There are 4 remainder operations performed.
|#

