#lang sicp
#| Answer:
Ben's method is not more efficient. Checking if all of the "k"s are integers is very inefficent.

.............................................
:          : 1st : 2nd : 3rd : 4th : 5th :  :
:..........:.....:.....:.....:.....:.....:..:
: Baker    :     :     :     :     : X   :  :
: Cooper   : X   :     : X   :     : X   :  :
: Fletcher : X   :     : X   :     : X   :  :
: Miller   : X   : X   :     :     :     :  :
: Smith    :     :     :     :     :     :  :
:..........:.....:.....:.....:.....:.....:..:


This is my table from the following clues:

Baker does not live on the top floor: Mark an X on Floor 5.

Cooper does not live on the boom floor: Mark an X on Floor 1.

Fletcher does not live on either the top or the boom floor: Mark an X on Floor 1 & 5.

Miller lives on a higher floor than does Cooper: Miller has to be on either 3, 4, or 5, so mark
an X on 1 & 2.

Fletcher does not live on a floor adjacent to Cooper’s: If Cooper lives on 3, there are no non-adjacent
floors for Fletcher, so Cooper cannot be on 3. Mark an X for Cooper on 3. Same thing for Fletch: if he's
on 3, Cooper cannot be non-adjacent. Mark an X for Fletcher on 3.

By my reasoning, there are 4 x 1 x 1 x 1 x 1 = 4 possibilities. I'd need to confirm by running the program
though.
|#
