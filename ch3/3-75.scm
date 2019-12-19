; avpt accumulates all values, rather than just averaging last value and current value.

(define (make-zero-crossings input-stream last-value last-avpt)
    (let ((avpt (/ (+ stream-car input-stream)
                   (last-value))))
        (cons-stream (sign-change-detector avpt last-avpt)
                     (make-zero-crossings (stream-cdr input-stream)
                                          (stream-car input-stream)
                                          avpt))))
