(define raise-list '(scheme-number rational complex))
(define (find-next type)
    (define (find-next-internal type type-list)
        (cond ((null? type-list)
               #f)
              ((eq? type (car type-list))
               (if (null? (cdr type-list)) #f (cadr type-list)))
              (else
               (find-next-internal type (cdr type-list)))))
    (find-next-internal type raise-list))

(define (scheme-number->rational x) ...)
(define (rational->complex x) ...)

(put-coercion 'scheme-number 'rational scheme-number->rational)
(put-coercion 'rational 'complex rational->complex)

(define (raise x)
    (let ((this-type (type-tag x))
          (next-type (find-next (type-tag x))))
        (if next-type
            ((get-coercion this-type next-type) x)
            (error "No raise method for this type -- RAISE" x))))

;; To add real between rational and complex, add real in raise-list and define rational->real and real->complex.
