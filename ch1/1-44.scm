(define (compose g f)
    (lambda (x) (g (f x))))

(define (repeated f n)
    (define (id x) x)
    (define (iter g i)
        (if (>= i n)
            g
            (iter (compose f g) (+ i 1))))
    (iter id 0))

(define (smooth f)
    (define dx 0.0001)
    (lambda (x) (/ (+ (f (- x dx)) (f x) (f (+ x dx))) 3.0)))

(define (smooth-n f n)
    ((repeated smooth n) f))

#||||||||||||||||||||||||||||||||||||||||||||||||||||||||#

(define (f x)
    (if (>= x 0)
        1
        -1))

(f -0.000001)
(f 0)
(f 0.000001)

((smooth-n f 10) -0.000001)
((smooth-n f 10) 0)
((smooth-n f 10) 0.000001)
