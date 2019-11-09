(define (cont-frac n d k)
    (define (iter i res)
        (if (= i 0)
            res
            (iter (- i 1) (/ (n i) (+ (d i) res)))))
    (iter k 0))

(define (tan-cf r k)
    (cont-frac (lambda (x) (if (= x 1) (- r) (- (square r))))
               (lambda (x) (+ (* (- 2) x) 1))
               k))

(define pi 3.141592653589793)
(tan-cf (/ pi 3) 10)    ; = (sqrt 3)
