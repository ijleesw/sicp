(define eps 0.001)
(define (close? a b) (< (abs (- a b)) eps))

(define (fixed-point f start)
    (define (try guess)
        (newline)
        (display guess)
        (let ((next (f guess)))
            (if (close? guess next)
                guess
                (try next))))
    (try start))

(define (fixed-point-avg f start)
    (define (try guess)
        (newline)
        (display guess)
        (let ((next (/ (+ guess (f guess)) 2)))
            (if (close? guess next)
                guess
                (try next))))
    (try start))

(fixed-point (lambda (x) (/ (log 1000) (log x))) 2.0)       ; 22 steps
(fixed-point-avg (lambda (x) (/ (log 1000) (log x))) 2.0)   ; 6 steps
