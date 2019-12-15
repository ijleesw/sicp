(load "stream-base.scm")

(define (show x)
    (newline) (display x) x)

(define x
    (stream-map show
                (stream-map show (stream-enumerate-interval 0 100))))

(stream-ref x 5)
(stream-ref x 7)
