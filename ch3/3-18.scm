(define (contains-cycle? x)
    (let ((visited ()))
        (define (internal x)
            (cond ((null? x) #f)
                  ((memq x visited) #t)
                  (else (set! visited (cons x visited))
                        (internal (cdr x)))))
        (internal x)))

(contains-cycle? '(1 2 3))

(define a '(1 2))
(set-cdr! a a)
(contains-cycle? a)
