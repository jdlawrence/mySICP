#lang racket
(define (jamil balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds!"))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown request -- MAKE-ACCOUNT" m))))
  dispatch)

#| Testing |#
(define j1 (jamil 100))

(j1 50)
(j1 50)
(j1 50)

(define a1 (make-account 100))
((a1 'withdraw) 75)
((a1 'deposit) 175)
((a1 'withdraw) 1750)

#| Answer |#
(define (make-accumulator init)
  (lambda (amount)
    (begin (set! init (+ init amount))
           init)))

(define A (make-accumulator 5))
(A 5)
(A 5)
(A 5)


   
               
                     