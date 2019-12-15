(define (display-stream-until n s)     ; n-th value included
    (if (< n 0)
        the-empty-stream
        (begin (newline) (display (stream-car s)) (display-stream-until (- n 1) (stream-cdr s)))))

; a.
(define (integrate-series seq)
    (define (div-streams s1 s2) (stream-map / s1 s2))
    (define (integers-from n) (cons-stream n (integers-from (+ n 1))))
    (div-streams seq (integers-from 1)))

(define powers-of-2 (cons-stream 1 (stream-map (lambda (x) (* x 2)) powers-of-2)))
(define s (integrate-series powers-of-2))
(display-stream-until 10 s)

; b.
(define cosine-series
    (cons-stream 1 (stream-map (lambda (x) (* x -1))
                               (integrate-series sine-series))))
(define sine-series
    (cons-stream 0 (integrate-series cosine-series)))

(display-stream-until 10 cosine-series)
(display-stream-until 10 sine-series)
