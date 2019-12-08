(define pair-list ())

(define (count-pairs x)
    (let ((pair-list ()))
        (define (count-pairs-internal x)
            (cond ((not (pair? x)) 0)
                  ((memq x pair-list) 0)
                  (else (set! pair-list (cons x pair-list))
                        (+ (count-pairs-internal (car x))
                           (count-pairs-internal (cdr x))
                           1))))
        (count-pairs-internal x)))

;; 3
(define a (cons () ()))
(define b (cons () ()))
(define c (cons () ()))
(set-cdr! a b)
(set-cdr! b c)
(count-pairs a)

;; 4
(define a (cons () ()))
(define b (cons () ()))
(define c (cons () ()))
(set-car! a b)
(set-cdr! a c)
(set-car! b c)
(count-pairs a)

;; 7
(define a (cons () ()))
(define b (cons () ()))
(define c (cons () ()))
(set-car! a b)
(set-cdr! a b)
(set-car! b c)
(set-cdr! b c)
(count-pairs a)

;; \inf
(define a (cons () ()))
(define b (cons () ()))
(define c (cons () ()))
(set-cdr! a b)
(set-cdr! b c)
(set-cdr! c a)
(count-pairs a)
