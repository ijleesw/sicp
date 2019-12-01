(define (=zero? x)
    (apply-generic '=zero? x))

;; And then add equ-type in each package. For example in complex,
(define (install-complex-package)
    ;; ...
    (put '=zero? '(complex)
        (lambda (z) (= (magnitude z) 0)))
    'done)

(install-complex-package)
