(define (integers-from n)
    (cons-stream n (integers-from (+ n 1))))

(define (mul-streams s1 s2)
    (stream-map * s1 s2))

(define fac
    (cons-stream 1 (mul-streams (integers-from 2) fac)))

(stream-ref fac 4)
(stream-ref fac 5)
