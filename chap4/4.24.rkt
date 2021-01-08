
#lang racket
#| Problem:
Design and carry out some experiments to
compare the speed of the original metacircular evaluator
with the version in this section. Use your results to estimate the fraction of time that is spent in analysis versus
execution for various procedures.

Answer:
Since I never got the metacircular evaluator running, I cannot do the comparison with the analyze-separately version.
However, if I could, I'd run some looping function 10 times, 100, 10,000 times, and a 1,000,000 times to compare the
differences.

Comparing answers I saw on the internet show anywhere from 25 - 50% gain from using the analyze-first version.
|#