(define rand
    (let ((seed 230))
        (lambda (m)
            (cond ((eq? m 'generate) (set! seed (rand-update seed)) seed)
                  ((eq? m 'reset) (lambda (new-value) (set! seed new-value)))
                  (else (error "Unknown command -- RAND" m))))))
