#lang racket
(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

(accumulate * 1 (list 1 2 3 4))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

#| Answers |#
#| A matrix times a vector is just the dot-product for each row
of the matrix with the vector |#
(define (matrix-*-vector m v)
  (map (lambda (x) (dot-product x v)) m))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

#| A transpose is turning rows into columns. Accumulate-n grabs a column
of a matrix by grabbing the nth value from each row |#
(define (transpose mat)
  (accumulate-n cons '() mat))

#| A matrix multiplication is taking the nth row of the first matrix (a vector),
and doing a matrix-*-vector operation with the second matrix to produce 
a new row. Do this for all n rows of the first matrix. |#
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) (matrix-*-vector cols x)) m)))

#| Testing |#
(define v (list 2 6))
(define w (list 3 8))
(define m (list (list 1 2) (list 3 4)))
(define l1 (list (list 1 2 3) (list 4 5 6) (list 7 8 9)))
(define l2 (list (list 1 2) (list 3 4) (list 5 6) (list 7 8)))
(define m1 (list (list 1 2) (list 3 4)))
(define m2 (list (list 4 3) (list 2 1)))

(accumulate-n + 0 l1)
(dot-product v w)

(matrix-*-vector m v)
;l1
(transpose l2)
(matrix-*-matrix m1 m2)