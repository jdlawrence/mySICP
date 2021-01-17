#lang sicp
#| Answer:
I'm not sure exactly, but I believe this is saying that instead of listing all of the floors for each person,
ie:

(let ((baker (amb 1 2 3 4 5)) (cooper (amb 1 2 3 4 5))
(fletcher (amb 1 2 3 4 5)) (miller (amb 1 2 3 4 5))
(smith (amb 1 2 3 4 5)))

we should cut down this list to floors that are possible from the clues that are given. For example, since
cooper cannot be on floor 1, we can cut that list down to:

(cooper (amb 2 3 4 5))



|#
