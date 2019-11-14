(define (div-interval x y)
    (if (<= (* (lower-bound y) (upper-bound y)) 0)
        (error "0 is included in the interval of denominator : " y)
        (mul-interval x
                      (make-interval (/ 1.0 (upper-bound y))
                                     (/ 1.0 (lower-bound y))))))
