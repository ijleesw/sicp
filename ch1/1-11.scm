(define (f-recur n)
        (cond ((< n 3) n)
              (else (+ (f-recur (- n 1)) (* 2 (f-recur (- n 2))) (* 3 (f-recur (- n 3)))))))

(f-recur 5)
(f-recur 12)

(define (f-iter n)
    (define (f-iter-sub a b c n)  ; n >= 3 when called from f-iter
            (cond ((< n 3) c)
                  (else (f-iter-sub b c (+ c (* 2 b) (* 3 a)) (- n 1)))))
    (cond ((< n 3) n)
          (else (f-iter-sub 0 1 2 n))))

(f-iter 5)
(f-iter 12)
