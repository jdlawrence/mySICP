#lang racket

#| Earlier in the text, we were given this function:
|#
(define (attach-tag type-tag contents)
  (cons type-tag contents))

#|
If we wanted, we could make a more specific version of this.
Let's call it "make-standard-record"
|#

(define (make-standard-record division record)
  (cons division record))

(define (get-division standard-record)
  (car standard-record))

(define (get-content standard-record)
  (cdr standard-record))



 
#| Part A Answer:
Standard records must include division so that we can look up the type of "get-record" and
"get-salary" functions to use.

The "get" function takes two parameters, a function name, like "get-record" and a division, so
that we can know which type of function to retrieve.

Once we retrieve the function, we pass it the employee's name, and the contents of file (we use
"get-content" to remove the division and get just the contents)

If the record doesn't exist, return null. If it does, make it a standard record by attaching
division in front of it.

|#
(define (get-record emp-name a-standard-file)
  (let (
        (record ((get 'get-record (get-division a-standard-file)) emp-name (get-content a-stardard-record)))
    )
    (if (null? record)
        '()
        (make-standard-record (get-division a-standard-record) record))))

