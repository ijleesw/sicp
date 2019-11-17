(define (accumulate op init seq)
    (if (null? seq)
        init
        (op (car seq) (accumulate op init (cdr seq)))))

(define (count-leaves t)
    (accumulate +
                0
                (map (lambda (x) (if (not (list? x))
                                     1
                                     (count-leaves x)))
                     t)))

(define tree (list 1 2 (list 3 4 5 (list 6 (list 7 8)) 9 10) 11))
(count-leaves tree)
