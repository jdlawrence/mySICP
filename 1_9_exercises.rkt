#lang sicp

#|
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))
|#

#|
(+ 4 5)
  (if (= 4 0)
    (inc (+ 4 4))
      (if (= 4 0)
        (inc (+ 3 4))
          (if (= 3 0)
            (inc (+ 2 4))
              (if (= 2 0))
                (inc (+ 1 4))
                  (if (= 1 0))
                    (inc (+ 0 4))
                      (if (= 0 0))
                        4)
                    (inc 4)
                (inc 5)
            (inc 6)
         (inc 7)
     (inc 8)
(9) 
|#

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
#|
(+ 4 5)
  (if (= 4 0) #f
    (+ 3 6)
      (if (= 3 0)
        (+ 2 7)
          (if (= 2 0)
            (+ 1 8)
              (if (= 1 0)
                (+ 0 9)
                  (if (= 0 0)
                    (9)
                (9)
            (9)
       (9)
    (9)
|#

(+ 4 5)


