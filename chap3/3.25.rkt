#lang sicp

#| NOTE: Going to come back to this one as I can't quite see
the structure properly. Maybe time will help! |#
(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup keys)
      (sub-lookup keys local-table))
    (define (sub-lookup keys curr-table)
      (let ((subtable
             (assoc (car keys) (cdr curr-table))))
        (if subtable
            (if (= (length keys) 1)
                (cdr (cdr curr-table))
                (sub-lookup (cdr keys) subtable))
            false)))
    (define (make-subs keys value)
      (if (null? keys)
          value
          (cons (car keys) (make-subs (cdr keys) value))))
    (define (insert! keys value)
      (sub-insert keys value local-table))
    (define (sub-insert keys value curr-table)
      (let ((subtable
             (assoc (car keys) (cdr curr-table))))
        (if subtable
            (if (= (length keys) 1)
                (set-cdr! curr-table value)
                (sub-insert (cdr keys) value subtable))
            (begin
              (set-cdr! curr-table (cons (make-subs keys value) '() ))
              'OK))))
        (define (dispatch m)
          (cond ((eq? m 'lookup-proc) lookup)
                ((eq? m 'insert-proc!) insert!)
                (else (error "Unknown operation: TABLE" m))))
        dispatch))

            
#| Testing |#
(define t (make-table))
(define get (t 'lookup-proc))
(define put (t 'insert-proc!))

;(put (list 'a 'b) 5)
;(get (list 'a 'b))
(list 'a 'b 'c)
