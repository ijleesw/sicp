(load "3-67.scm")

(define (triples s1 s2 s3)
    (cons-stream (list (stream-car s1) (stream-car s2) (stream-car s3))
                 (interleave (stream-map (lambda (x) (cons (stream-car s1) x))
                                         (stream-cdr (pairs s2 s3)))
                             (triples (stream-cdr s1) (stream-cdr s2) (stream-cdr s3)))))

(define integers (integers-from 0))
(define integer-triples (triples integers integers integers))
(display-stream-until 100 integer-triples)
