(define f
    (let ((a 1))
        (lambda (x)
            (if (= x 0)
                (begin (set! a 0) a)
                (* a x)))))

(define (left) (begin (display "left") 0))
(define (right) (begin (display "right") 0))
(+ (left) (right))  ; evaluated from right to left

; (+ (f 0) (f 1)) ; (f 1) first
; (+ (f 1) (f 0)) ; (f 0) first
