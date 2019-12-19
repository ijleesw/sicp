(define (sqrt-stream x)
    (define ss (cons-stream 1.0 (stream-map (lambda (e) (/ (+ e (/ x e)) 2)) ss)))
    ss)

(define (stream-limit s tolerance)
    (define (helper prev s)
        (if (< (abs (- prev (stream-car s))) tolerance)
            (stream-car s)
            (helper (stream-car s) (stream-cdr s))))
    (helper (stream-car s) (stream-cdr s)))

(define (sqrt x tolerance)
    (stream-limit (sqrt-stream x) tolerance))

(sqrt 2 0.00001)
(sqrt 3 0.00001)
