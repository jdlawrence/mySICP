#lang sicp

#| Answer
Can a semaphore be a list of mutexes?


|#

(define (make-stack)
  (define my-stack (cons 1 (cons 2 '())))

  (define (pop)
    (define (pop-helper a-stack)
      (let ((result (car  a-stack)))
      (set!  my-stack (cdr  a-stack))
      result))
    (pop-helper  my-stack))

  (define (push x)
    (define (push-helper x  a-stack)
      (set!  my-stack (cons x  a-stack)))
    (push-helper x  my-stack))
  (define (empty?)
    (define (empty-helper  a-stack)
      (if (null? a-stack) #t
          #f))
    (empty-helper my-stack))
  (define (print)
    (define (print-helper  a-stack)
      (if (empty?) '()
          (display a-stack)))
    (print-helper  my-stack))

  (define (dispatch method)
    (cond 
      ((eq? method 'pop) pop)
      ((eq? method 'push) push)
      ((eq? method 'print) print)
      (else (lambda() (display "Unknown Request: ")(display method)(newline)))))
  dispatch)

(define s (make-stack))
s

((s 'push) 3)
((s 'print))

(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell) (set-car! cell false))

#| Answer in terms of mutexes |#

(define (make-semaphore n )
  (let (
        (count 0) ; To count the number of mutexes currently active
        (lock (make-mutex)) ; To make sure our actual don't interleave with each other
        )
    (define (dispatch m)
      (cond ((eq? m 'acquire)
             (lock 'acquire) ; Use the lock to 'acquire so that we won't be interrupted
             ; If count is is less than n, call 'release on the lock mutex and increase the count
             (if (< count n)
                 (begin
                   (set! count (+ count 1))
                   (lock 'release)) ; Release when we we're done 
                 ; If not, call 'release, but keep trying to acquire
                 (begin
                   (lock 'release)
                   (dispatch 'acquire))))
            ; If release is called, assuming count is greater than 0 and we have mutexes to release,
            ; decrease the count with an 'acquire and 'release 
            ((eq? m 'release)
             (if (> count 0)
                 (lock 'acquire)
                 (begin
                   (set! count (- count 1))
                   (lock 'release))))))
    dispatch))


#| Answer in terms of test-and-set! |#
(define (make-semaphore n )
  (let (
        (count 0) ; To count the number of mutexes currently active
        (lock (list false)) ; Use a single cell
        )
    (define (dispatch m)
      (cond ((eq? m 'acquire)
             ; If we're busy, then keep retrying by dispatching 'acquire
             (if (test-and-set! lock)
                 (dispatch 'acquire))
             ; If count is is less than n, call test-and-set! and increase count
             (test-and-set! lock)
             (if (< count n)
                 (begin
                   (set! count (+ count 1))
                   (clear! lock)) ; Clear when we we're done 
                 ; If not, call 'release, but keep trying to acquire
                 (begin
                   (clear! lock)
                   (dispatch 'acquire))))
             ; If release is called, assuming count is greater than 0 and we have mutexes to release,
             ; decrease the count with an 'acquire and 'release 
            ((eq? m 'release)
             (if (> count 0)
                 (lock 'acquire)
                 (begin
                   (set! count (- count 1))
                   (lock 'release))))))
    dispatch))