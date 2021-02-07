#lang sicp

(meeting accounting (Monday 9am))
(meeting administration (Monday 10am))
(meeting computer (Wednesday 3pm))
(meeting administration (Friday 1pm))

; Each of the above assertions is for a meeting of an entire division.
; Ben also adds an entry for the company-wide meeting that spans all
; the divisions. All of the company’s employees attend this meeting.

(meeting whole-company (Wednesday 4pm))
#|
a. On Friday morning, Ben wants to query the data base
for all the meetings that occur that day. What query
should he use?
|#

(meeting ?department (Monday . ?time))

#|
b. Alyssa P. Hacker is unimpressed. She thinks it would
be much more useful to be able to ask for her meetings
by specifying her name. So she designs a rule that says
that a person’s meetings include all whole-company
meetings plus all meetings of that person’s division.
Fill in the body of Alyssa’s rule.
|#

(rule (meeting-time ?person ?day-and-time)
      (or (meeting whole-company ?day-and-time) ; Either the meeting is a whole-company meeting at the given day and time
          (and (job ?person (?division . ?rest)) ; Or, we query the person's division
               (meeting ?division ?day-and-time)))); and use the division to query with the "meeting" rule

#|
c. Alyssa arrives at work on Wednesday morning and
wonders what meetings she has to aend that day.
Having defined the above rule, what query should she
make to find this out?
|#

; Since rules don't return all of the details, we need to "and" the meetings query with one that will return
; the division's meeting details

(and (meeting-time (Hacker Alyssa P) (Wednesday ?t)) (meeting ?dept (Wednesday ?t)))
