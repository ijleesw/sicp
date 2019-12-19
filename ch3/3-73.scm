(load "stream-base.scm")

(define (integral integrand init-val dt)
    (define int
        (cons-stream init-val
                     (add-streams (scale-stream integrand dt) int)))
    int)

(define (RC R C dt)
    (lambda (i v0)
            (add-streams (scale-stream i R)
                         (integral (scale-stream i (/ 1.0 C))
                                   v0
                                   dt))))
