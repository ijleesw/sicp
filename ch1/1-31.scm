(define (product-recur f a next b)
    (if (> a b)
        1
        (* (f a) (product-recur f (next a) next b))))

(define (product-iter f a next b)
    (define (iter a res)
        (if (> a b)
            res
            (iter (next a) (* (f a) res))))
    (iter a 1))

(define (pi prod n)
    (define (f x) (/ (* (- x 1) (+ x 1)) x x))
    (* 4.0 (prod f 3 (lambda (x) (+ x 2)) n)))

(pi product-recur 1000)
(pi product-iter 1000)
