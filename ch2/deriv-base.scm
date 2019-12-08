(define (variable? x) (symbol? x))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num) (and (number? exp) (= exp num)))
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list '+ a1 a2))))
(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list '* m1 m2))))
(define (sum? x) (and (list? x) (eq? (car x) '+)))
(define (augend s) (cadr s))
(define (addend s) (caddr s))
(define (product? x) (and (list? x) (eq? (car x) '*)))
(define (multiplicand p) (cadr p))
(define (multiplier p) (caddr p))

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp)
           (if (same-variable? exp var) 1 0))
          ((sum? exp)
           (make-sum (deriv (augend exp) var)
                     (deriv (addend exp) var)))
          ((product? exp)
           (make-sum (make-product (deriv (multiplicand exp) var)
                                   (multiplier exp))
                     (make-product (multiplicand exp)
                                   (deriv (multiplier exp) var))))
          (else
           (error "unknown expression type -- DERIV" exp))))