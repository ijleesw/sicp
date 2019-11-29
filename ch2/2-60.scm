;; slower
(define (element-of-set? x set)
    (cond ((null? set) #f)
          ((equal? x (car set)) #t)
          (else (element-of-set? x (cdr set)))))

;; faster
(define (adjoin-set x set)
    (cons x set))

;; faster
(define (union-set set1 set2)
    (append set1 set2))

;; slower
(define (intersection-set set1 set2)
    (cond ((or (null? set1) (null? set2)) ())
          ((element-of-set? (car set1) set2)
           (cons (car set1) (intersection-set (cdr set1) set2)))
          (else
           (intersection-set (cdr set1) set2))))

(define s1 '(1 3 5 7 9 11))
(define s2 '(10 9 8 7 6 5 4 3 2 1 0))

(element-of-set? 1 s1)
(element-of-set? 2 s1)

(adjoin-set 1 s1)

(union-set s1 s2)

(intersection-set s1 s2)
