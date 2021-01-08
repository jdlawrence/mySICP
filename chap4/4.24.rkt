#lang sicp
#| Problem:
Design and carry out some experiments to
compare the speed of the original metacircular evaluator
with the version in this section. Use your results to estimate the fraction of time that is spent in analysis versus
execution for various procedures.

Answer:
Using the analyze-separtely version of eval, I ran the following function:
|#

(define (fib n) 
     (if (<= n 2) 
         1 
         (+ (fib (- n 1)) (fib (- n 2)))))

#|
I invoked with (fib 30), and in three trials, it took an average of 7.23 seconds. The original version at the beginning of chapter
4 took an average of 9.33 seconds. Therefore, the time devoted to analysis is about 29%.

|#
