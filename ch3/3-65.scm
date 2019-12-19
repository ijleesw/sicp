(define (display-stream-until n s)
    (if (= n 0)
        'done
        (begin (newline) (display (stream-car s)) (display-stream-until (- n 1) (stream-cdr s)))))

(define (alt-stream n)
    (define (helper n factor)
        (cons-stream (/ 1.0 factor n) (helper (+ n 1) (* factor -1))))
    (helper n 1))

(define (partial-sums s)
    (define ps (stream-map + s (cons-stream 0 ps)))
    ps)

(define ln2-stream (partial-sums (alt-stream 1)))
(display-stream-until 10 ln2-stream)

(define (euler-transform s)
    (let ((s0 (stream-ref s 0))
          (s1 (stream-ref s 1))
          (s2 (stream-ref s 2)))
     (cons-stream (- s2 (/ (square (- s2 s1)) (+ s0 (* -2 s1) s2)))
                  (euler-transform (stream-cdr s)))))

(define ln2-stream2 (euler-transform ln2-stream))
(display-stream-until 10 ln2-stream2)

(define (tableau transform s)
    (cons-stream s (tableau transform (transform s))))

(define (accelerated-stream transform s)
    (stream-map stream-car (tableau transform s)))

(define ln2-stream3 (accelerated-stream euler-transform ln2-stream))
(display-stream-until 10 ln2-stream3)
