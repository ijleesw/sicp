(define (last-pair li)
    (if (null? (cdr li))
        (list (car li))
        (last-pair (cdr li))))

(last-pair (list 1))
(last-pair (list 1 3 5 7 9))
