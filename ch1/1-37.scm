(define (cont-frac n d k)
    (define (iter i res)
        (if (= i 0)
            res
            (iter (- i 1) (/ (n i) (+ (d i) res)))))
    (iter k 0))

(/ 1 (cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 11))  ; 1.6179...
(/ 1 (cont-frac (lambda (x) 1.0) (lambda (x) 1.0) 12))  ; 1.6180...

(define (cont-frac-recur n d k)
    (define (recur n d l)
        (if (> l k)
            0
            (/ (n l) (+ (d l) (recur n d (+ l 1))))))
    (recur n d 1))

(/ 1 (cont-frac-recur (lambda (x) 1.0) (lambda (x) 1.0) 12))  ; 1.6180...
