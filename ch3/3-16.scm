(define (count-pairs x)
    (if (not (pair? x))
        0
        (+ (count-pairs (car x))
           (count-pairs (cdr x))
           1)))

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
