#lang racket

(define (accumulate op initial sequence)
   (if (null? sequence)
       initial
       (op (car sequence)
           (accumulate op initial (cdr sequence)))))

(accumulate + 0 (list 1 2 3 4 5))

(define (enumerate-interval low high)
  (if (> low high)
      '()
      (cons low (enumerate-interval (+ low 1) high))))

(accumulate
 append '() (map (lambda (i)
                   (map (lambda (j) (list i j))
                        (enumerate-interval 1 (- i 1))))
                 (enumerate-interval 1 5)))

(map (lambda (i)
       (list i))
     ;(map (lambda (j) (list i j))
     ;     (enumerate-interval 1 (- i 1))))
     (enumerate-interval 1 3))