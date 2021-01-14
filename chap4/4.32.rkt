#lang sicp
#| Answer:
With lazy car and cdr as we have here, we can delay both functions until we need them. This gives us
the advantage of being able to deal with infinitely large data structures, like the tree of all
the possible moves in a chess game.
|#