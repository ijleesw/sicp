(define (integers-from n)
    (cons-stream n (integers-from (+ n 1))))

(define (display-stream-until n s)
    (if (= n 0) 'done
        (begin (newline) (display (stream-car s)) (display-stream-until (- n 1) (stream-cdr s)))))

(define (pairs s1 s2)
    (cons-stream (list (stream-car s1) (stream-car s2))
                 (interleave (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2))
                             (pairs (stream-cdr s1) (stream-cdr s2)))))

(define (interleave s1 s2)
    (if (stream-null? s1) s2 (cons-stream (stream-car s1) (interleave s2 (stream-cdr s1)))))

(define ps (pairs (integers-from 0) (integers-from 0)))
(display-stream-until 100 ps)

(define (full-pairs s1 s2)
    (cons-stream (list (stream-car s1) (stream-car s2))
                 (interleave (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2))
                             (full-pairs (stream-cdr s1) s2))))
(define fps (full-pairs (integers-from 0) (integers-from 0)))
(display-stream-until 100 fps)
