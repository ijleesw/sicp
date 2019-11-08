(define (smallest-divisor n)
        (find-divisor n 2))

(define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
              ((divides? test-divisor n) test-divisor)
              ((= test-divisor 2) (find-divisor n (+ test-divisor 1)))
              (else (find-divisor n (+ test-divisor 2)))))

(define (divides? a b) (= (modulo b a) 0))

(define (prime? n) (= n (smallest-divisor n)))

(define (timed-prime-test n)
    (newline)
    (display n)
    (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
    (if (prime? n)
        (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
    (display " *** ")
    (display elapsed-time))

(define (search-for-primes l r)
    (if (<= l r)
        (check-and-search-next l r l)))

(define (check-and-search-next l r cur)
    (cond ((> cur r))
          ((= (modulo cur 2) 0) (check-and-search-next l r (+ cur 1)))
          (else (timed-prime-test cur) (check-and-search-next l r (+ cur 2)))))

(search-for-primes 10000000019 10000000019)
(search-for-primes 100000000003 100000000003)
(search-for-primes 1000000000039 1000000000039)

; not twice faster, because of additional overhead (such as an additional branch condition)
