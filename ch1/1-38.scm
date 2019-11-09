(define (cont-frac n d k)
    (define (iter i res)
        (if (= i 0)
            res
            (iter (- i 1) (/ (n i) (+ (d i) res)))))
    (iter k 0))

(define (N i) 1)
(define (D i)
    (if (= (modulo i 3) 2)
        (* (+ i 1) (/ 2 3))
        1))

(+ (cont-frac N D 100) 2.0)
