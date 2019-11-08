(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
    (define (try-it a) (= (expmod a n n) a))
    (define (fermat-test-sub a)
        (if (= a n) #t
            (and (try-it a) (fermat-test-sub (+ a 1)))))
    (fermat-test-sub 1))

(fermat-test 561)
(fermat-test 1105)
(fermat-test 1729)
(fermat-test 2465)
(fermat-test 2821)
(fermat-test 6601)
