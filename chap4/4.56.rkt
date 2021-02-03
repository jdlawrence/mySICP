#lang sicp
#|

a. the names of all people who are supervised by Ben
Bitdiddle, together with their addresses;|#
(and (supervisor ?person (Bitdiddle Ben))
     (address ?person ?where))
#|
b. all people whose salary is less than Ben Bitdiddle’s,
together with their salary and Ben Bitdiddle’s salary;
|#

; Use this query to find out that Ben Bitdiddle's salary is 60000
(salary (Ben Bitdiddle) ?amount)

; Then this query
(and (salary (Bitdiddle Ben) ?benSalary)
     (salary ?person ?personSalary)
     (lisp-value < ?benSalary ?personSalary))

#|
c. all people who are supervised by someone who is not
in the computer division, together with the supervisor’s name and job.
|#
(and
 (supervisor ?supervisorName ?person)
 (not (job ?person (computer . ?other)))
 (job ?supervisorName ?supervisorJob)) 



