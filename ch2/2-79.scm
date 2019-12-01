(define (equ? x y)
    (apply-generic 'equ? x y))  ;; assume x and y have the same type, like in cases of other operations.

;; And then add equ-type in each package. For example in complex,
(define (install-complex-package)
    ;; ...
    (define (equ?-complex z1 z2)
        (let ((eps 1e-10))
            (and (< (abs (- (real-part z1) (real-part z2))) eps)
                 (< (abs (- (imag-part z1) (imag-part z2))) eps))))
    ;; ...
    (put 'equ? '(complex complex) equ?-complex)
    'done)

(install-complex-package)
