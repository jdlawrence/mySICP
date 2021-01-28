#lang racket
(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

#|

(define (flatmap proc li) 
  (if (null? li) 
      '() 
      (let ((result (proc (car li))) 
            (rest (flatmap proc (cdr li)))) 
        (if (pair? result) 
            (append result rest) 
            (cons result rest))))) 
  
(define (permutations lists) 
  (if (null? lists) 
      '(()) 
      (flatmap (lambda (x)  
                 (map (lambda (y) (cons x y))  
                      (permutations (cdr lists)))) 
               (car lists)))) 
  
(define (restrictions l) 
  (apply 
   (lambda (baker cooper fletcher miller smith) 
     (and (> miller cooper) 
          (not (= (abs (- smith fletcher)) 1)) 
          (not (= (abs (- fletcher cooper)) 1)) 
          (distinct? (list baker cooper fletcher miller smith)))) 
   l))

#|
(define (filter aList pred)
  (if (null? aList)
      '()
      (if (pred (car aList))
          (cons (car aList) (filter (cdr aList) pred))
          (filter (cdr aList) pred))))

(filter '(1 2 3 4 5) (lambda (x) (= (modulo x 2) 0)))
|#

  
(define (multiple-dwelling) 
  (let ((baker '(1 2 3 4)) 
        (cooper '(2 3 4 5)) 
        (fletcher '(2 3 4)) 
        (miller '(3 4 5)) 
        (smith '(1 2 3 4 5))) 
;    (filter restrictions (permutations (list baker cooper fletcher miller smith)))))
    (permutations (list baker cooper fletcher miller smith))))

(multiple-dwelling)
|#

(define (flatmap proc li) 
  (if (null? li) 
      '() 
      (let ((result (proc (car li))) 
            (rest (flatmap proc (cdr li)))) 
        (if (pair? result) 
            (append result rest) 
            (cons result rest)))))

;(flatmap (lambda (x) (* x 2))
;        (list 1 '(2 3)))
  
(define (permutations lists) 
  (if (null? lists) 
      '(()) 
      (flatmap (lambda (x)  
                 (map (lambda (y) (cons x y))  
                      (permutations (cdr lists)))) 
               (car lists)))) 
#|
Permutations:
- Takes in all of the lists, ie (list '(1 2 3) '(a b c) '(x y z)), etc
- Takes the first list, ie '(1 2 3)
- Flatmap procedure is a lambda that takes in an x, and combines the x in a cons with every permutation of all the other lists
- The lambda 'x' is the first value in the first list, ie 1
- The permutations of the rests of the list end up

|#
(define (restrictions l) 
  (apply 
   (lambda (baker cooper fletcher miller smith) 
     (and (> miller cooper) 
          ;(not (= (abs (- smith fletcher)) 1)) 
          ;(not (= (abs (- fletcher cooper)) 1)) 
          (distinct? (list baker cooper fletcher miller smith)))) 
   l)) 
  
(define (multiple-dwelling) 
  (let ((baker '(1 2 3 4)) 
        (cooper '(2 3 4 5)) 
        (fletcher '(2 3 4)) 
        (miller '(3 4 5)) 
        (smith '(1 2 3 4 5))) 
    (filter restrictions (permutations (list baker cooper fletcher miller smith)))))

;(permutations (list '(a b) '(c d)))
;(permutations (list '(j d) '(l)))
;(permutations (list '(j)))
;(multiple-dwelling)
;(not (= 5 2))
;(not (= 5 5))

(define (inc x) (+ x 1))

(define (safe? solution)
  (let ((firstVal (car solution)))
    (define (conflict val1 val2 i)
      (if  (or
              (= val1 val2)
              (= val1 (+ val2 i))
              (= val1 (- val2 i)))
           true
           false))
    (define (iter remaining index)
      (cond ((null? remaining) true)
            ((conflict firstVal (car remaining) index) false)
            (else (iter (cdr remaining) (+ 1 index)))))
    (iter (cdr solution) 1)))

(safe? '(1 2 3 4))
;(cons 5 '( 2 8 6))
