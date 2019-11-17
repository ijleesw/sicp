(define (subsets s)
    (if (null? s)
        (list ())
        (let ((rest (subsets (cdr s))))
            (append (map (lambda (x) (cons (car s) x)) rest)
                    rest))))

(subsets (list 1 2 3 4))
