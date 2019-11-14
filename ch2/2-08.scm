(define (sub-interval z1 z2)
    (let ((l (- (lower-bound z1) (upper-bound z1)))
          (u (- (upper-bound z1) (lower-bound z2))))
        (make-interval l u)))
