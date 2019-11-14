(define (mul-interval x y)
    (make-center-percent (* (center x) (center y))
                         (+ (percent x) (percent y))))
