(load "deriv-base.scm")

(define (addend s)
    (if (= (length s) 3)
        (caddr s)
        (cons '+ (cddr s))))
(define (multiplier p)
    (if (= (length p) 3)
        (caddr p)
        (cons '* (cddr p))))

(deriv '(* x y (+ x 3)) 'x)
(deriv '(* x y (+ x 3 y)) 'x)

;; Can optimize by modifying make-sum and make-product to receive a list... omitted.
