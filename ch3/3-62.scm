(load "3-61.scm")

(define (div-series s1 s2)
    (if (= (stream-car s2) 0)
        (error "denominator should have a nonzero constant term -- DIV-SERIES" s2)
        (mul-series s1 (invert-unit-series s2))))

(define sin-div-cos (div-series sine-series cosine-series))
(display-stream-until 11 sin-div-cos)
