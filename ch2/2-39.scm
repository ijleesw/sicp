(define (reverse seq)
    (fold-right (lambda (x res) (append res (list x))) () seq))

(reverse (list 2 3 4))

(define (reverse seq)
    (fold-left (lambda (res x) (cons x res)) () seq))

(reverse (list 2 3 4))
