(load "3-59.scm")

(define (add-streams s1 s2) (stream-map + s1 s2))
(define (mul-streams s1 s2) (stream-map * s1 s2))
(define (scale-stream s factor) (stream-map (lambda (x) (* x factor)) s))

(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                              (mul-series (stream-cdr s2) s1))))

(define circle-series
    (add-streams (mul-series cosine-series cosine-series)
                 (mul-series sine-series sine-series)))

(define (eval-until n series x)
    (define (iter sum factor cnt s)
        (if (>= cnt n)
            sum
            (iter (+ sum (* factor (stream-car s)))
                  (* factor x)
                  (+ cnt 1)
                  (stream-cdr s))))
    (iter 0.0 1.0 0 series))

(display-stream-until 30 circle-series)
