#|
(define (same-parity x . li)
    (define (same-parity-iter li res)
        (let ((x-parity (modulo x 2)))
            (cond ((null? li) res)
                  ((= (modulo (car li) 2) x-parity) (same-parity-iter (cdr li) (cons (car li) res)))
                  (else (same-parity-iter (cdr li) res)))))
    (same-parity-iter li (list x)))
|#  ;; this version returns reversed list

(define (same-parity x . li)
    (define (same-parity-recur parity li)
        (cond ((null? li) ())
              ((= parity (modulo (car li) 2)) (cons (car li) (same-parity-recur parity (cdr li))))
              (else (same-parity-recur parity (cdr li)))))
    (same-parity-recur (modulo x 2) (cons x li)))

(same-parity 3 4 5 6 7 8 9)
(same-parity 2 3 4 5 6 7 8)
