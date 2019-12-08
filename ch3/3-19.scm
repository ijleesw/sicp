(define (contains-cycle? x)
    (define (internal tortoise hare)
        (cond ((or (null? hare) (null? (cdr hare))) #f)
              ((eq? hare tortoise) #t)
              (else (internal (cdr tortoise) (cddr hare)))))
    (internal x (cdr x)))

(contains-cycle? '(1 2 3))

(define a '(1 2))
(set-cdr! a a)
(contains-cycle? a)
