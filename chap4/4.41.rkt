#lang sicp
#|


(define (multiple-dwelling)
  (let ((baker (amb 1 2 3 4 5)) (cooper (amb 1 2 3 4 5))
                                (fletcher (amb 1 2 3 4 5)) (miller (amb 1 2 3 4 5))
                                (smith (amb 1 2 3 4 5)))
    (require
      (distinct? (list baker cooper fletcher miller smith)))
    (require (not (= baker 5)))
    (require (not (= cooper 1)))
    (require (not (= fletcher 5)))
    (require (not (= fletcher 1)))
    (require (> miller cooper))
    (require (not (= (abs (- smith fletcher)) 1)))
    (require (not (= (abs (- fletcher cooper)) 1)))
    (list (list 'baker baker) (list 'cooper cooper)
          (list 'fletcher fletcher) (list 'miller miller)
          (list 'smith smith))))
|#
#| Answer:
This is maybe not efficient, but I'm going to generate the permutation of the numbers 1 to 5, ie
12345, 12354, 12435, 12453, 12534, 12543, ...54321 and then filter the results.

NOTE: I ended up using a solution I found online and debugging it to find out how it works. It
produces all permutations and then filters. I also created several javascript versions that
I posted in 4.41.js. 

|#

(define (distinct? items)
  (cond ((null? items) true)
        ((null? (cdr items)) true)
        ((member (car items) (cdr items)) false)
        (else (distinct? (cdr items)))))

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
  
 (define (mutiple-dwelling) 
   (let ((baker '(1 2 3 4)) 
         (cooper '(2 3 4 5)) 
         (fletcher '(2 3 4)) 
         (miller '(3 4 5)) 
         (smith '(1 2 3 4 5))) 
     (filter restrictions (permutations (list baker cooper fletcher miller smith))))) 
