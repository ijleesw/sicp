(define (sqrt-stream x)
    (cons-stream 1.0 (stream-map (lambda (guess) (sqrt-improve guess x)) (sqrt-stream x))))
(define (sqrt-improve guess x)
    (average guess (/ x guess)))
(define (average x . xs)
    (/ (apply + (cons x xs)) (+ (length xs) 1)))
(define sqrt2 (sqrt-stream 2))

(define (time proc . args)
    (newline)
    (display "time-elapsed: ")
    (let ((start-time (runtime)))
        (define res (apply proc args))
        (display (- (runtime) start-time))
        res))

; warm-up
(define sqrt2 (sqrt-stream 2))
(stream-ref sqrt2 4000)

; test
(define sqrt2 (sqrt-stream 2))
(time stream-ref sqrt2 1000)
(define sqrt2 (sqrt-stream 2))
(time stream-ref sqrt2 2000)
(define sqrt2 (sqrt-stream 2))
(time stream-ref sqrt2 3000)
(define sqrt2 (sqrt-stream 2))
(time stream-ref sqrt2 4000)
