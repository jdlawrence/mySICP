#lang sicp

(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item)
  (set-car! queue item))
(define (set-rear-ptr! queue item)
  (set-cdr! queue item))


(define (empty-queue? queue)
  (null? (front-ptr queue)))


(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))


(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else (set-front-ptr! queue (cdr (front-ptr queue)))
              queue)))

(define q1 (make-queue))
q1
(insert-queue! q1 'a)
(insert-queue! q1 'b)
(insert-queue! q1 'c)
(insert-queue! q1 'd)
;(delete-queue! q1)
;(delete-queue! q1)
(empty-queue? q1)

#| Answer:
The standard Lisp (Scheme/Racket) interpreter is showing a cons with the entire list
representing the queue in the first position and the last item in the list in the second
position of the queue.

After the first insert, the queue front and rear point to the same element, hence the
((a) a).

After the second insert ('b), the front is a list consisting of '(a b), and the rear
still points to be 'b.

After the first delete, the front and rear both point to 'b
After the second delete, the front points to null, and the rear points to be. This is the
way the delete queue was designed. You can tell that the list is empty because
empty-queue?, which just checks if the front is null, returns true.
|#

(define (print-queue q)
  (cond ((empty-queue? q)  "")
        (else (display (front-queue q)) (display " -> ") (print-queue (cons (cdr (front-ptr q)) (rear-ptr q))))))

(print-queue q1)
(delete-queue! q1)
(print-queue q1)
(insert-queue! q1 'j)
(print-queue q1)




          