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

(define (make-semaphore n )
  (let ((count 0))
    (define (dispatch m)
      (cond ((eq? m 'acquire)
             (if (< count n)
                 (begin
                   ((make-mutex) 'acquire)
                   (set! count (+ count 1)))
                 (dispatch 'acquire)))
            ((eq? m 'release)
             (if (> count 0)
                 (begin
                   (set! count (- count 1))
                   ; Maybe do something else to release a mutex?
                   )))))
    dispatch))


