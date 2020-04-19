#lang sicp

(define (make-table)
  (list '*table*))

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record
        (cdr record)
        false)))
(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record
        (set-cdr! record value)
        (set-cdr! table
                  (cons (cons key value)
                        (cdr table)))))
  'ok)

(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result
             (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))

(define memo-fib
  (memoize
   (lambda (n)
     (cond ((= n 0) 0)
           ((= n 1) 1)
           (else (+ (memo-fib (- n 1))
                    (memo-fib (- n 2))))))))
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

;(memo-fib 3)
((memoize fib) 3)
#| Answer
(memo-fib n) is proportional to n because the call to (memo-fib (- n 2)) never has to be calculated, except for
the base cases. It will always be found in the table. To figure out the number of calls, we count down from n
to 0, inclusive. Therefore, the total number of calls is n + 1, since we have to include 0.

Calling ((memoize fib) n) only stores the final result of (fib n) in the table. This is because the recursive
call in fib calls fib itself, and not a memoized version of fib.
|#