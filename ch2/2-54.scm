(define (equal? l1 l2)
    (cond ((null? l1) (null? l2))
          ((null? l2) (null? l1))
          (else (and (eq? (car l1) (car l2))
                     (equal? (cdr l1) (cdr l2))))))

(equal? '(this is a list) '(this is a list))
(equal? '(this is a list) '(this is a list 2))
(equal? '(this is a list) '(this (is a) list))
