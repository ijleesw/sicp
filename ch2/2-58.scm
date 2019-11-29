(load "2.3.2.scm")

;; a.
(define (make-sum a1 a2)
    (cond ((=number? a1 0) a2)
          ((=number? a2 0) a1)
          ((and (number? a1) (number? a2)) (+ a1 a2))
          (else (list a1 '+ a2))))
(define (sum? x) (and (list? x) (eq? (cadr x) '+)))
(define (augend s) (car s))
(define (addend s)
    (if (= (length s) 3)
        (caddr s)
        (cddr s)))

(define (make-product m1 m2)
    (cond ((or (=number? m1 0) (=number? m2 0)) 0)
          ((=number? m1 1) m2)
          ((=number? m2 1) m1)
          ((and (number? m1) (number? m2)) (* m1 m2))
          (else (list m1 '* m2))))
(define (product? x) (and (list? x) (eq? (cadr x) '*)))
(define (multiplicand p) (car p))
(define (multiplier p)
    (if (= (length p) 3)
        (caddr p)
        (cddr p)))

(deriv '(x + (3 * (x + (y + 2)))) 'x)
(deriv '(x * (x + 2)) 'x)

;; b.
;; Basically, it's a problem of checking the existence of a operator with lower precedence.
(define (precedence op)
	(cond ((eq? '+ op) 0)
		  ((eq? '* op) 1)
		  (else (error "unknown operator -- PRECEDENCE" op))))

(define (lowest-precedence-op? op exp)
    (if (= (length exp) 1)
        #t
        (and (<= (precedence op) (precedence (cadr exp)))
             (lowest-precedence-op? op (cddr exp)))))

(define (lhs op exp)
    (cond ((null? exp) ())
          ((eq? op (car exp)) ())
          (else (cons (car exp) (lhs op (cdr exp))))))
(define (rhs op exp)
    (let ((memq-res (memq op exp)))
         (if memq-res
             (cdr memq-res)
             (error "op not in exp -- RHS" op exp))))
(define (flat exp)
    (if (and (list? exp) (null? (cdr exp))) (car exp) exp))

(define (sum? exp)
    (and (memq '+ exp)
         (lowest-precedence-op? '+ exp)))
(define (augend s) (flat (lhs '+ s)))
(define (addend s) (flat (rhs '+ s)))

(define (product? exp)
    (and (memq '* exp)
         (lowest-precedence-op? '* exp)))
(define (multiplicand s) (flat (lhs '* s)))
(define (multiplier s) (flat (rhs '* s)))

(deriv '(x + x + x) 'x)
(deriv '(x + x * x) 'x)
(deriv '(x * x + x) 'x)
(deriv '(x * x * x) 'x)
