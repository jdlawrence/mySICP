#lang racket
#| Given |#
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (make-record key value)
  (cons key value))

(define (key record)
  (car record))

(define (value record)
  (cdr record))

(define j (make-record 1 "jamil"))

(key j)
(value j)

#|
(define (lookup-unordered given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (car set-of-records)))
         (car set-of-records))
        (else (lookup given-key (cdr set-of-records)))))
|#


(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((equal? given-key (key (entry set-of-records))) (entry set-of-records))
        ((< given-key (key (entry set-of-records))) (lookup given-key (left-branch set-of-records)))
        (else (lookup given-key (right-branch set-of-records)))))
