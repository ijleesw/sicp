(define (square-list li)
    (if (null? li)
        ()
        (cons (square (car li)) (square-list (cdr li)))))

(square-list (list 1 3 5 7 9))

(define (square-list li)
    (map square li))

(square-list (list 1 3 5 7 9))
