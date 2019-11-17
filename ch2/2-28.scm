(define (fringe x)
    (cond ((null? x) x)
          ((not (pair? x)) (list x))
          (else (append (fringe (car x)) (fringe (cdr x))))))

(define x (list (list 1 2 3) (list 4 (list 5 6) 7) 8))
(fringe x)
