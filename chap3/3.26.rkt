#lang sicp

#| Answer:

The basics of using a binary tree for a table is that lookup
is no longer linear, but now is logarithmic. Given a list of keys,
say ('a 'c 'd), we determine whether 'a is in the left or right half
of the tree, and start traversing that half appropriately. Much of
the code remains the same, but the assoc function can be rewritten.

Each entry in the table should have a should contain a record,
which consists of a key and value, and a reference to a left and right entry.
|#

