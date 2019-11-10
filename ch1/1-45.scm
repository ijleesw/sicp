(define (average-damp f)
    (lambda (x) (/ (+ x (f x)) 2)))

(define (fixed-point f a)
    (define (close? x y)
        (< (abs (- x y)) 0.00001))
    (let ((next (f a)))
        (if (close? a next)
            a
            (fixed-point f next))))

(define (compose g f)
    (lambda (x) (g (f x))))

(define (repeated f n)
    (define (iter g i)
        (if (>= i n)
            g
            (iter (compose f g) (+ i 1))))
    (iter f 1))

#||||||||||||||||||||||||||||||||||||||||||||||||||#

(define (n-sqrt x n)
    (fixed-point ((repeated average-damp n-damp)
                  (lambda (y) (/ x (expt y (- n 1)))))
                 1.0))

(define n-damp 2)
(n-sqrt 100 4)

(define n-damp 2)
(n-sqrt 100 5)

(define n-damp 1)
(n-sqrt 100 6)

(define n-damp 1)
(n-sqrt 100 7)

(define n-damp 1)
(n-sqrt 100 8)

(define n-damp 1)
(n-sqrt 100 9)

(define n-damp 1)
(n-sqrt 100 10)

(define n-damp 1)
(n-sqrt 1000 11)

(define n-damp 1)
(n-sqrt 1000 12)

; n-damp's are all manually-found lower bounds... looks like (floor (log2 n)) not always the lower bound.
