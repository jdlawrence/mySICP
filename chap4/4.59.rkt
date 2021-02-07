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
