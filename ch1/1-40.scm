(define (cube x) (* x x x))

(define (cubic a b c)
    (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

(define (newtons-method g guess)
    (fixed-point-of-transform newton-transform g guess))

(define (fixed-point-of-transform transform g guess)
    (fixed-point (transform g) guess))

(define (fixed-point g guess)
    (define eps 0.00001)
    (define (close? a b)
        (< (abs (- a b)) eps))
    (let ((next (g guess)))
        (if (close? guess next)
           guess
           (fixed-point g next))))

(define (newton-transform g)
    (lambda (x) (- x (/ (g x) ((deriv g) x)))))

(define (deriv g)
    (lambda (x) (/ (- (g (+ x dx)) (g x) ) dx)))

(define dx 0.0001)

#||||||||||||||||||||||||||||||||||||||||||||||||||||#

(define a -2)
(define b -3)
(define c  4)   ; x^3 - 2x^2 - 3x + 4

(define fixed-pt (newtons-method (cubic a b c) -4))
fixed-pt
((cubic a b c) fixed-pt)

(define fixed-pt (newtons-method (cubic a b c) 0))
fixed-pt
((cubic a b c) fixed-pt)

(define fixed-pt (newtons-method (cubic a b c) 20))
fixed-pt
((cubic a b c) fixed-pt)
