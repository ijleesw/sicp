(define (double a) (+ a a))
(define (halve a) (quotient a 2))
(define (even? a) (= (modulo a 2) 0))

(define (fast-mult a b)
        (cond ((= b 0) 0)
              ((= b 1) a)
              ((even? b) (fast-mult (double a) (halve b)))
              (else (+ a (fast-mult (double a) (halve b))))))

(fast-mult 47 81)   ; 3807
