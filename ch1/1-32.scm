(define (accum-recur combiner null-value term a next b)
    (if (> a b)
        null-value
        (combiner (term a) (accum-recur combiner null-value term (next a) next b))))

(define (sum term a next b)
    (accum-recur (lambda (x y) (+ x y)) 0 term a next b))

(sum (lambda (x) (square x)) 1 (lambda (x) (+ x 1)) 11)  ; 506


(define (accum-iter combiner null-value term a next b)
    (define (iter cur res)
        (if (> cur b)
            res
            (iter (next cur) (combiner res (term cur)))))
    (iter a null-value))

(define (product term a next b)
    (accum-iter (lambda (x y) (* x y)) 1 term a next b))

(product (lambda (x) (+ (* x 2) 1)) 1 (lambda (x) (+ x 1)) 5)  ; 10395
