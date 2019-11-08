(define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (get-squared-remainder (expmod base (/ exp 2) m) m))
          (else
           (remainder (* base (expmod base (- exp 1) m)) m))))

(define (get-squared-remainder val m)
    (if (and (= (remainder (square val) m) 1)
             (not (= (remainder val m) 1))
             (not (= (remainder val m) (- m 1))))
        0
        (remainder (square val) m)))

(define (count-zero n)
    (define (count-zero-sub n a c)
        (cond ((= a n) c)
              ((= (expmod a (- n 1) n) 0)
               (count-zero-sub n (+ a 1) (+ c 1)))
              (else (count-zero-sub n (+ a 1) c))))
    (count-zero-sub n 1 0))

#|
(define (counter a n)
    (cond ((> a n) 0)
          (else (newline)
                (display a)
                (display " -> ")
                (display (count-zero a))
                (counter (+ a 1) n))))
|#

(define (miller-rabin n)
    (cond ((= n 2) true)
          ((= (remainder n 2) 0) false)
          (else (= (count-zero n) 0))))


(miller-rabin 561)
(miller-rabin 1105)
(miller-rabin 1729)
(miller-rabin 2465)
(miller-rabin 2821)
(miller-rabin 6601)    ; all #f

(miller-rabin 100003)  ; #t
(miller-rabin 100153)  ; #t
(miller-rabin 100279)  ; #t
(miller-rabin 100389)  ; #f
