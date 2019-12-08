(define head '(1 2 3 4))
(define tail (cdddr head))
(define queue (cons head tail))

(define (print-queue queue)
    (newline)
    (display (car queue)))

(print-queue queue)
