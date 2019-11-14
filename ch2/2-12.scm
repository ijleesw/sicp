(define (upper-bound x) (max (car x) (cdr x)))
(define (lower-bound x) (min (car x) (cdr x)))

(define (make-center-percent c p)
    (let ((w (* c (+ 1 (/ p 100)))))
        (cons (- c w) (+ c w))))

(define (percent x)
    (let ((c (/ (+ (upper-bound x) (lower-bound x)) 2)))
        (* (- (/ (- (upper-bound x) c) c) 1) 100)))

(define cp (make-center-percent 105 12.3))
(percent cp)
