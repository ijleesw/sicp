(define (double g)
    (lambda (x) (g (g x))))

(define (inc x)
    (+ x 1))

(((double (double double)) inc) 5)  ; 21
; (double double) : apply 4 times
; (double (double double)) : apply (apply 4 times) 2 times = apply 16 times

((((double double) double) inc) 5)  ; 21
; (double double) : apply 4 times
; ((double double) double) : apply (apply 2 times) 4 times = apply 16 times
