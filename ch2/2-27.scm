(define (deep-reverse x)
    (define (iter old new)
        (if (null? old)
            new
            (iter (cdr old) (cons (deep-reverse (car old)) new))))
    (if (not (pair? x))
        x
        (iter x ())))

(define x (list (list 1 2 3) (list 4 (list 5 6) 7) 8))
x
(deep-reverse x)

#|
(A variant of) Brillant solution by jz at http://community.schemewiki.org/?sicp-ex-2.27

(define (deep-reverse x)
    (if (not (pair? x))
        x
        (append (deep-reverse (cdr x))
                (list (deep-reverse (car x))))))
|#
