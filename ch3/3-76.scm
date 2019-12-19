(define (average x . xs)
    (/ (apply + (cons x xs))
       (+ (length xs) 1)))
(define (display-stream-until s n)
    (if (or (stream-null? s) (= n 0))
        'done
        (begin (newline)
               (display (stream-car s))
               (display-stream-until (stream-cdr s) (- n 1)))))
(define (integers-from n) (cons-stream n (integers-from (+ n 1))))
(define integers (integers-from 0))

(define (identity x) x)
(define (smooth s) (stream-map average s (stream-cdr s)))
(display-stream-until (smooth integers) 10)

(define (make-zero-crossings input-stream signal-filter)
    (define (sign-change-detector prev next)
        (cond ((equal? next the-empty-stream) 0)
              ((and (>= prev 0) (< next 0)) -1)
              ((and (< prev 0) (>= next 0)) 1)
              (else 0)))
    (let ((filtered-stream (signal-filter input-stream)))
        (stream-map sign-change-detector
                    (cons-stream 0 filtered-stream)
                    filtered-stream)))

(define signal (stream 1 2 1.5 1 0.5 -0.1 -2 -3 -2 -0.5 0.2 3 4 -1 0 0 -1 0 0 2 0))

(display-stream-until (make-zero-crossings signal identity) 25)
(display-stream-until (make-zero-crossings signal smooth) 25)
