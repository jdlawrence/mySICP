(define (solve f y0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (stream-map f y))
  y)
#| Will this procedure work if internal definitions are scanned
out as shown in this exercise?

Answer:

No, I don't think this will work. I don't believe delays and streams can be unassigned. Also,
isn't the whole point of a stream to avoid assignment, and to define and calculate only when
needed?

|#
