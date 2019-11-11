(define (make-segment p1 p2) (cons p1 p2))
(define (start-segment s) (car s))
(define (end-segment s) (cdr s))

(define (make-point x y) (cons x y))
(define (x-point p) (car p))
(define (y-point p) (cdr p))

(define (midpoint-segment s)
    (let ((start (start-segment s))
          (end (end-segment s))
          (avg (lambda (a b) (/ (+ a b) 2))))
        (make-point (avg (x-point start) (x-point end))
                    (avg (y-point start) (y-point end)))))

(define p1 (make-point 1.0 3.0))
(define p2 (make-point 7.6 1.8))
(define s (make-segment p1 p2))
(midpoint-segment s)
