(define (accumulate op init seq)
    (if (null? seq)
        init
        (op (car seq)
            (accumulate op init (cdr seq)))))

(define (horner-eval x coeffs)
    (accumulate (lambda (coeff res) (+ coeff (* res x)))
                0
                coeffs))

(horner-eval 2 (list 1 3 0 5 0 1))
