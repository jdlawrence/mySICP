#lang sicp

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
