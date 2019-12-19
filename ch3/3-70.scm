(define (integers-from n)
    (cons-stream n (integers-from (+ n 1))))

(define (display-stream-until n s)
    (if (= n 0) 'done
        (begin (newline) (display (stream-car s)) (display-stream-until (- n 1) (stream-cdr s)))))

(define (merge-weighted weight s1 s2)
    (cond ((stream-null? s1) s2)
          ((stream-null? s2) s1)
          (else (if (< (weight (stream-car s1)) (weight (stream-car s2)))
                    (cons-stream (stream-car s1) (merge-weighted weight (stream-cdr s1) s2))
                    (cons-stream (stream-car s2) (merge-weighted weight s1 (stream-cdr s2)))))))

(define (weighted-pairs weight s1 s2)
    (cons-stream (list (stream-car s1) (stream-car s2))
                 (merge-weighted weight
                                 (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2))
                                 (weighted-pairs weight (stream-cdr s1) (stream-cdr s2)))))

(define integers (integers-from 0))

; a.
(define (weight-a pair) (+ (car pair) (cadr pair)))
(define ps (weighted-pairs weight-a integers integers))
(display-stream-until 100 ps)

; b.
(define (weight-b pair) (+ (* 2 (car pair)) (* 3 (cadr pair)) (* 5 (car pair) (cadr pair))))
(define filtered-integers
    (stream-filter (lambda (x) (and (> (modulo x 2) 0)
                                    (> (modulo x 3) 0)
                                    (> (modulo x 5) 0)))
                   integers))
(define ps (weighted-pairs weight-b filtered-integers filtered-integers))
(display-stream-until 100 ps)
