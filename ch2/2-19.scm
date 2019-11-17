(define (cc amount coin-values)
    (cond ((= amount 0) 1)
          ((or (< amount 0) (no-more? coin-values)) 0)
          (else
            (+ (cc amount (except-first-denomination coin-values))
               (cc (- amount (first-denomination coin-values)) coin-values)))))

(define (no-more? li)
    (null? li))

(define (first-denomination li)
    (car li))

(define (except-first-denomination li)
    (cdr li))

(cc 100 (list 50 25 10 5 1))  ;; (1)
(cc 100 (list 1 5 10 25 50))  ;; (2)

;; The order of coins does not affect the result.
;; It's because if given a tuple (a, b, c, d, e) where 100 = 50a + 25b + 10c + 5d + 1e which is found in (1),
;;    (2) also finds (a, b, c, d, e) by recursing procedure cc e, d, c, b, a times
;;    with (first-denomination coin-values) == 1, 5, 10, 25, 50, respectively.
