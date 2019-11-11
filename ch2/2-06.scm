(define zero
    (lambda (f) (lambda (x) x)))
(define one
    (lambda (f) (lambda (x) (f x))))
(define two
    (lambda (f) (lambda (x) (f (f x)))))

#|
It can be easily proved that (n f) is (lambda (x) (f (f .. (f x) .. ))) where f is repeated n times by induction.

((add n m) f) = ((n+m) f)
              = (lambda (x) (f^(n+m) x))
              = (lambda (x) ((lambda (x) (f^n x)) (f^m x)))
              = (lambda (x) ((lambda (x) (f^n x)) ((lambda (x) (f^m x)) x)))
              = (lambda (x) ((n f) ((m f) x)))
|#

(define (add n m)
    (lambda (f) (lambda (x) ((n f) ((m f) x)))))
