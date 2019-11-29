(define (element-of-set? x set)
    (cond ((null? set) #f)
          ((equal? x (car set)) #t)
          (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
    (if (element-of-set? x set)
        set
        (cons x set)))

(define (intersection-set set1 set2)
    (cond ((or (null? set1) (null? set2)) ())
          ((element-of-set? (car set1) set2)
           (cons (car set1) (intersection-set (cdr set1) set2)))
          (else (intersection-set (cdr set1) set 2))))

;; btw, iterative method will be more efficient
(define (union-set set1 set2)
    (cond ((null? set1) set2)
          ((element-of-set? (car set1) set2)
           (union-set (cdr set1) set2))
          (else
           (union-set (cdr set1) (cons (car set1) set2)))))

(union-set '(1 3 5 7 9 11 13) '(10 9 8 7 6 5 4 3 2 1 0))
