(define (iterative-improve good-enough? improve)
    (lambda (x)
        (define (iter x)
            (if (good-enough? x)
                x
                (iter (improve x))))
        (iter x)))

(define eps 0.00001)

(define (sqrt x)
    (define (good-enough? a) (< (abs (- (square a) x)) eps))
    (define (improve a) (/ (+ a (/ x a)) 2))
    ((iterative-improve good-enough? improve) x))

(sqrt 2.0)

(define (fixed-point f x)
    (define (good-enough? a) (< (abs (- a (f a))) eps))
    (define (improve a) (/ (+ a (f a)) 2))
    ((iterative-improve good-enough? improve) x))

(fixed-point cos 1.0)
