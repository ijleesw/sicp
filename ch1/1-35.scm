(define eps 0.00001)
(define (close? a b) (< (abs (- a b)) eps))

(define (fixed-point f start)
    (define (try guess)
        (let ((next (f guess)))
            (if (close? guess next)
                guess
                (try next))))
    (try start))

(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)
