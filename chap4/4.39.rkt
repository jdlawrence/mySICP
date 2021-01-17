#lang sicp
#| Answer:
I believe that the order does not matter for the total number of outcomes, but that it will matter
for the total time to completion. Ideally you'd pick something that eliminates the most possibilities
at once. For example, putting the statement:

(require (not (= (abs (- smith fletcher)) 1)))

before others doesn't directly eliminate any choices for fletcher, so you must go through all the choices
for him before going back and eliminating the appropriate ones for smith. However if you put these statements:

(require (not (= fletcher 5)))
(require (not (= fletcher 1)))

first, then you have less an easier choice for smith.
|#
