(define (make-semaphore n)
    (let ((mutex (make-mutex))
          (cnt 0))
        (define (the-sema m)
            (cond ((eq? m 'P)
                   (mutex 'acquire)
                   (if (>= cnt n)
                       (begin (mutex 'release) (the-sema m))  ; release and retry
                       (begin (set! cnt (+ cnt 1)) (mutex 'release))))  ; inc cnt and release
                  ((eq? m 'V)
                   (mutex 'acquire)
                   (set! cnt (- cnt 1))
                   (mutex 'release))))
        the-sema))

; For the second problem, replace mutex 'acquire and 'release with their definition, or modify test-and-set! to receive n and check (car cell) is less than n or not.
