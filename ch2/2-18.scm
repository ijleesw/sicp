(define (reverse li)
    (define (reverse-iter old-li new-li)
        (if (null? old-li)
            new-li
            (reverse-iter (cdr old-li) (cons (car old-li) new-li))))
    (reverse-iter li ()))

(reverse ())
(reverse (list 1))
(reverse (list 1 3 5 7))
