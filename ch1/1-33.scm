(define (smallest-divisor n)
        (find-divisor n 2))
(define (find-divisor n test-divisor)
        (cond ((> (square test-divisor) n) n)
              ((divides? test-divisor n) test-divisor)
              (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (modulo b a) 0))
(define (prime? n) (if (< n 2) #f (= n (smallest-divisor n))))

#|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||#

(define (filtered-accumulate combiner null-value predicate term a next b)
    (define (iter cur res)
        (cond ((> cur b) res)
              ((predicate cur) (iter (next cur) (combiner res (term cur))))
              (else (iter (next cur) (combiner res null-value)))))
    (iter a null-value))


(define (sum-squared-primes a b)
    (filtered-accumulate (lambda (x y) (+ x y)) 0 prime? square a (lambda (x) (+ x 1)) b))

(sum-squared-primes 1 12)  ; 208

(define (prod-coprimes n)
    (filtered-accumulate (lambda (x y) (* x y)) 1 (lambda (x) (= (gcd x n) 1)) (lambda (x) x) 1 (lambda (x) (+ x 1)) n))

(prod-coprimes 12)  ; 385
