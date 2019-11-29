(define (union-list list1 list2)
    (cond ((null? list1) list2)
          ((null? list2) list1)
          (else
           (let ((x1 (car list1))
                 (x2 (car list2)))
                (cond ((= x1 x2)
                       (cons x1 (union-list (cdr list1) (cdr list2))))
                      ((< x1 x2)
                       (cons x1 (union-list (cdr list1) list2)))
                      ((> x1 x2)
                       (cons x2 (union-list list1 (cdr list2)))))))))

(define (intersection-list list1 list2)
    (cond ((null? list1) list2)
          ((null? list2) list1)
          (else
           (let ((x1 (car list1))
                 (x2 (car list2)))
                (cond ((= x1 x2)
                       (cons x1 (intersection-list (cdr list1) (cdr list2))))
                      ((< x1 x2)
                       (intersection-list (cdr list1) list2))
                      ((> x1 x2)
                       (intersection-list list1 (cdr list2))))))))

(define (union-set set1 set2)
    (let ((list1 (tree->list-2 set1))
          (list2 (tree->list-2 set2)))
        (list->tree (union-list list1 list2))))

(define (intersection-set set1 set2)
    (let ((list1 (tree->list-2 set1))
          (list2 (tree->list-2 set2)))
        (list->tree (intersection-list list1 list2))))
