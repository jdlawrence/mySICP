#lang racket
(define (square n) (* n n))
(define nil '())
(define (accumulate op initial items)
  (if (null? items)
      initial
      (op (car items) (accumulate op initial (cdr items)))))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

#| Answers
|#
(define (unique-pairs n)
  (flatmap (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
           (enumerate-interval 2 n)))

#| Answer |#
(define (unique-triplets n)
  (flatmap (lambda (i) i)
           (flatmap (lambda (i)
                      (map (lambda (j)
                             (map (lambda (k) (list i j k))
                                  (enumerate-interval 1 (- j 1))))
                           (enumerate-interval 1 (- i 1))))
                    (enumerate-interval 3 n))))

(define (filtered-triplets sum items)
  (filter (lambda (item) (= sum (accumulate + 0 item))) items))

(define (triplet-sum n sum)
  (filtered-triplets sum (unique-triplets n)))
#| Extra credit |#
(define (unique-fourplex n)
  (flatmap (lambda (i) i)
           (flatmap (lambda (i) i)
                    (flatmap (lambda (i)
                               (map (lambda (j)
                                      (map (lambda (k)
                                             (map (lambda (l) (list i j k l))
                                                  (enumerate-interval 1 (- k 1))))
                                           (enumerate-interval 1 (- j 1))))
                                    (enumerate-interval 1 (- i 1))))
                             (enumerate-interval 4 n))))) 
#| Testing |#
;(unique-pairs 4)
;(unique-triplets 3)
;(unique-fourplex 8)
(triplet-sum 9 8) 