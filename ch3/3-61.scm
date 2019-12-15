(load "3-60.scm")

(define (invert-unit-series s)
    (define ius
        (cons-stream 1 (scale-stream (mul-series (stream-cdr s) ius) -1)))
    ius)

(define exp-series (cons-stream 1 (integrate-series exp-series)))
(define inverted-exp-series (invert-unit-series exp-series))
(display-stream-until 12 inverted-exp-series)  ; same as coeff. of e^x if x to the power of even, negate coeff. otherwise.
