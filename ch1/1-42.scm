(define (compose g f)
    (lambda (x) (g (f x))))

(define inc
    (lambda (x) (+ x 1)))

((compose square inc) 6)
