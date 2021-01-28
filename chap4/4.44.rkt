#lang sicp

; Given a board like (3 1 4 2), which represent the column position of each queen in a column,
; we can detect if there are any conflicts within rows, columns or diagonals.
(define (safe? solution)
  (let ((firstVal (car solution)))
    (define (conflict val1 val2 i)
      (if  (or
              (= val1 val2)
              (= val1 (+ val2 i))
              (= val1 (- val2 i)))
           true
           false))
    (define (iter remaining index)
      (cond ((null? remaining) true)
            ((conflict firstVal (car remaining) index) false)
            (else (iter (cdr remaining) (+ 1 index)))))
    (iter (cdr solution) 1)))
  
(define (queens n)
  (define (iter solution remaining)
    (if (= remaining 0)
        solution-so-far
        (begin
          (let ((attempt (cons (an-integer-between 1 n) solution)))
            (require (safe? attempt))
            (iter attempt (- remaining 1))))))
  (iter '() n))


                     
  