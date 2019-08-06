#lang racket
(define (make-leaf symbol weight) (list 'leaf symbol weight))
(define (leaf? object) (eq? (car object) 'leaf))
(define (symbol-leaf x) (cadr x))
(define (weight-leaf x) (caddr x))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))

(define (symbols tree)
  (if (leaf? tree)
      (list (symbol-leaf tree))
      (caddr tree)))

(define (weight tree)
  (if (leaf? tree)
      (weight-leaf tree)
      (cadddr tree)))

(define (make-code-tree left right)
  (list left
        right
        (append (symbols left) (symbols right))
        (+ (weight left) (weight right))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree
                    (make-leaf 'D 1)
                    (make-leaf 'C 1)))))

(define (decode bits tree)
  (define (decode-1 bits current-branch)
    (if (null? bits)
        '()
        (let ((next-branch
               (choose-branch (car bits) current-branch)))
          (if (leaf? next-branch)
              (cons (symbol-leaf next-branch)
                    (decode-1 (cdr bits) tree))
              (decode-1 (cdr bits) next-branch)))))
  (decode-1 bits tree))

(define (choose-branch bit branch)
  (cond ((= bit 0) (left-branch branch))
        ((= bit 1) (right-branch branch))
        (else (error "bad bit: CHOOSE-BRANCH" bit))))
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoin-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs)
      '()
      (let ((pair (car pairs)))
        (adjoin-set (make-leaf (car pair) ; symbol
                               (cadr pair)) ; frequency
                    (make-leaf-set (cdr pairs))))))

(define (generate-huffman-tree pairs)
(successive-merge (make-leaf-set pairs)))

(define (successive-merge set)
      (cond ((null? set) '())
            ((null? (cdr set)) (car set))
            (else (successive-merge (adjoin-set (make-code-tree (car set) (cadr set)) (cddr set))))))

(define (combine-first-two set)
  (make-code-tree (car set) (cadr set)))

(define (one-step set)
  (adjoin-set (make-code-tree (car set) (cadr set)) (cddr set)))



(define (branch-contains symbol-list symbol)
  (cond ((null? symbol-list) #f)
        ((eq? (car symbol-list) symbol) #t)
        (else (branch-contains (cdr symbol-list) symbol))))

(branch-contains (symbols sample-tree) 'B)

(define (encode-symbol symbol tree)
  (if (leaf? tree)
      '()
      (cond ((branch-contains (symbols (left-branch tree)) symbol) (cons 0 (encode-symbol symbol (left-branch tree))))
            ((branch-contains (symbols (right-branch tree)) symbol) (cons 1 (encode-symbol symbol (right-branch tree))))
            (else (error "This tree doesn't contain this symbol")))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))


#| Testing |#
(define p1 '((A 4) (B 2) (C 1) (D 1)))
(define l1 (make-leaf-set '((A 4) (B 2) (C 1) (D 1))))
(define song '((na 16) (yip 9) (Sha 3) (Get 2) (a 2) (job 2) (Wah 1) (boom 1)))

#| Answer |#
(length (encode
         '(
           Get a job
               Sha na na na na na na na na
               Wah yip yip yip yip yip yip yip yip yip
               Sha boom) (generate-huffman-tree song)))

#| 58 bits are required. If we had used the fixed length code, there would be 3 * 24 = 72 bits required.  |#

