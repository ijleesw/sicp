(define (enumerate-interval l r)
    (if (> l r) () (cons l (enumerate-interval (+ l 1) r))))

(define (accumulate op init seq)
    (if (null? seq) init (op (car seq) (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
    (accumulate append () (map proc seq)))

(define (queens board-size)
    (define (queen-cols k)
        (if (= k 0)
            (list empty-board)
            (filter (lambda (positions)
                            (safe? k positions))
                    (flatmap (lambda (rest-of-queens)
                                     (map (lambda (new-row)
                                                  (adjoin-position new-row k rest-of-queens))
                                          (enumerate-interval 1 board-size)))
                             (queen-cols (- k 1))))))
    (queen-cols board-size))

;; Board is represented as an ordered list of (col, row), like ((5 4) (4 2) (3 5) (2 3) (1 1))

(define empty-board ())

(define (adjoin-position new-row k rest-of-queens)
    (cons (list k new-row) rest-of-queens))

(define (safe? k positions)
    (define (iter col row remaining-positions)
        (if (null? remaining-positions)
            #t
            (let ((cmp-pos (car remaining-positions)))
                (and (not (= row (cadr cmp-pos)))
                     (not (= (abs (- col (car cmp-pos)))
                             (abs (- row (cadr cmp-pos)))))
                     (iter col row (cdr remaining-positions))))))
    (let ((new-pos (car positions)))
        (iter (car new-pos) (cadr new-pos) (cdr positions))))

(define (count seq) (fold-right (lambda (elt sum) (+ 1 sum)) 0 seq))

(count (queens 4))
(queens 4)
(count (queens 5))
(queens 5)
(count (queens 6))
(queens 6)
(count (queens 7))
(count (queens 8))
(count (queens 9))


#|
Another representation by atomik at http://community.schemewiki.org/?sicp-ex-2.42 :

Board is represented as an ordered list of rows, like (4 2 5 3 1) in the above case.
Then, (safe? k positions) is defined using the sub-procedure (iter rest-of-board queen right-diagonal left-diagonal).
|#
