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
(define (get-record emp-name a-standard-record)
  (let (
        (record ((get 'get-record (get-division a-standard-record)) emp-name (get-content a-stardard-record)))
        )
    (if (null? record)
        '()
        (make-standard-record (get-division a-standard-record) record))))

#| Part B Answer:
To work for any division, this employee's record must tell which division they're from.

Again, we use the division type to determine which "get-salary" function to retrieve. Once we have that,
we pass the content of the record to the function.

If the record doesn't exist, return null, else add the division to the salary.
|#
(define (get-salary a-standard-record)
  (let (
        (record ((get 'get-salary (get-division a-standard-record)) (get-content a-stardard-record)))
        )
    (if (null? record)
        '()
        (make-standard-record (get-division a-standard-record) record))))

#| Part C Answer:
- Loop all over division records, calling "get-record" for each one until the name matches
or we reach the end of list. To check for name matching, we need a "get-name" function
that takes in a standard-record and the division and returns the name

|#

(define (find-employee-record emp-name list-of-division-records)
  (cond ((null? list-of-division-records) '())
        (else
         (let ((record (get-record emp-name (car list-of-division-records))))
              (if (null? record)
                  (find-employee-record emp-name (cdr list-of-division-records))
                  record)))))
#| Part D Answer:
When Insatiable takes over, a package must be created that tag each company's "get-record",
"get-salary" etc functions for general use using "put". Once this is done, we use the
"get-division" function to determine which division's function to use, and they can implement
the functions and underlying data structures however they like.
|#