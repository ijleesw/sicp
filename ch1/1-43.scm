(define (compose g f)
    (lambda (x) (g (f x))))

(define (repeated f n)
    (define id (lambda (x) x))
    (define (iter g i)
        (if (>= i n)
            g
            (iter (compose f g) (+ i 1))))
    (iter id 0))

((repeated square 2) 5)
((repeated (lambda (x) (+ (square x) 1)) 3) 2)  ; 677
