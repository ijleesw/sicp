(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m)) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))

(define (fermat-test n)
    (define (try-it a)
        (= (expmod a n n ) a))
    (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
    (cond ((= times 0) true)
          ((fermat-test n) (fast-prime? n (- times 1)))
          (else false)))

(define TIMES 50000)

(define (prime? n)
    (fast-prime? n TIMES))

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

(search-for-primes 1000000007 1000000007)         ; 1.82
(search-for-primes 10000000019 10000000019)       ; 2.13 ~ 1.82 * (10/9)
(search-for-primes 100000000003 100000000003)     ; 2.37 ~ 2.13 * (11/10)
(search-for-primes 1000000000039 1000000000039)   ; 2.51 ~ 2.37 * (12/11)
