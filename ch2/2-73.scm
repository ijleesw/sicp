(define op-list ())  ;; ( (op types proc) (op types proc) ... )
(define (get op type-list)
    (define (check op-list)
        (cond ((null? op-list) #f)
              ((and (equal? op (car (car op-list))) (equal? type-list (cadr (car op-list))))
               (caddr (car op-list)))
              (else
               (check (cdr op-list)))))
    (check op-list))
(define (put op type-list proc)
    (set! op-list (cons (list op type-list proc) op-list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2) (and (variable? v1) (variable? v2) (eq? v1 v2)))
(define (=number? exp num) (and (number? exp) (= exp num)))

(define (deriv exp var)
    (cond ((number? exp) 0)
          ((variable? exp) (if (same-variable? exp var) 1 0))
          (else ((get 'deriv (list (operator exp))) (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; a.
;; Process expression as a tagged data - operator is treated as a tag.
;; number? and variable? remained because they don't have type; they can, but it will be too messy.

;; b.
(define (install-sum-package)
    (define (make-sum a1 a2)
        (cond ((=number? a1 0) a2)
              ((=number? a2 0) a1)
              ((and (number? a1) (number? a2)) (+ a1 a2))
              (else (list '+ a1 a2))))

    (define (deriv-sum args var)
        (let ((lhs-dx (deriv (car args) var))
              (rhs-dx (deriv (cadr args) var)))
            (make-sum lhs-dx rhs-dx)))

    (put 'deriv '(+) deriv-sum)
    'done)

(define (install-mul-package)
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

    (define (deriv-mul args var)
        (let ((lhs (car args))
              (rhs (cadr args))
              (lhs-dx (deriv (car args) var))
              (rhs-dx (deriv (cadr args) var)))
            (make-sum (make-product lhs rhs-dx)
                      (make-product lhs-dx rhs))))

    (put 'deriv '(*) deriv-mul)
    'done)

(install-sum-package)
(install-mul-package)

(deriv '(* (* x y) (+ x 3)) 'x)

;; c.
(define (install-exp-package)
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

    (define (make-exp b e)
        (cond ((=number? b 1) 1)
              ((=number? e 1) b)
              ((=number? b 0) (if (= e 0) (error "0^0 not defined" b e) 0))
              ((=number? e 0) 1)
              ((and (number? b) (number? e)) (expt b e))
              (else (list '** b e))))

    (define (deriv-exp args var)
        (let ((base (car args))
              (exponent (cadr args)))
            (make-product (make-product exponent
                                        (make-exp base (make-sum exponent -1)))
                          (deriv base var))))

    (put 'deriv '(**) deriv-exp)
    'done)

(install-exp-package)

(deriv '(* (+ x 1) (** x 3)) 'x)

;; d.
;; change the order or parameters of put/get procedure
