(define (double a) (+ a a))
(define (halve a) (quotient a 2))
(define (even? a) (= (modulo a 2) 0))

(define (fast-mult a b)
    (define (fast-mult-sub s a b)
            (cond ((= b 0) s)
                  ((even? b) (fast-mult-sub s (double a) (halve b)))
                  (else (fast-mult-sub (+ s a) (double a) (halve b)))))
    (fast-mult-sub 0 a b))

(fast-mult 47 81)   ; 3807
