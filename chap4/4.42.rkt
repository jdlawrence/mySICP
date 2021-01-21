#lang racket
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

#|
(define (restrictions l) 
  (apply 
   (lambda (baker cooper fletcher miller smith) 
     (and (> miller cooper) 
          (not (= (abs (- smith fletcher)) 1)) 
          (not (= (abs (- fletcher cooper)) 1)) 
          (distinct? (list baker cooper fletcher miller smith)))) 
   l))
|#
  
(define (multiple-dwelling) 
  (let ((baker '(1 2 3 4)) 
        (cooper '(2 3 4 5)) 
        (fletcher '(2 3 4)) 
        (miller '(3 4 5)) 
        (smith '(1 2 3 4 5))) 
    (filter restrictions (permutations (list baker cooper fletcher miller smith)))))

#| Answers below: |#
(define (restrictions l) 
  (apply 
   (lambda (betty ethel joan kitty mary)
     (and 
          (xor (= kitty 2) (= betty 3))

          (xor (= ethel 1) (= joan 2))

          (xor (= joan 3) (= ethel 5))

          (xor (= kitty 2) (= mary 4))

          (xor (= mary 4) (= betty 1))
          
          (distinct? (list betty ethel joan kitty mary))))
   l))

(define (liars)
  (let (
        (betty '(1 2 3 4 5))
        (ethel '(1 2 3 4 5))
        (joan '(1 2 3 4 5))
        (kitty '(1 2 3 4 5))
        (mary '(1 2 3 4 5)))
    (filter restrictions (permutations (list betty ethel joan kitty mary)))))

(liars); Betty 3rd, Ethel 5th, Joan 2nd, Kitty 1st, Mary 4th