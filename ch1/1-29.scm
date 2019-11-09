(define (sum f a next b cnt)
    (cond ((> a b) 0)
          ((or (= cnt 0) (= a b)) (+ (f a) (sum f (next a) next b (+ cnt 1))))
          ((= (remainder cnt 2) 1) (+ (* 4 (f a)) (sum f (next a) next b (+ cnt 1))))
          (else (+ (* 2 (f a)) (sum f (next a) next b (+ cnt 1))))))

(define (integral f a b n)
    (define (next x) (+ x (/ (- b a) n)))
    (* (/ (- b a) n 3) (sum f a next b 0)))

(integral (lambda (x) (* x x x)) 0 1 5)
(integral (lambda (x) (* x x x)) 0 1 10)
(integral (lambda (x) (* x x x)) 0 1 100)
(integral (lambda (x) (* x x x)) 0 1 1000)

(integral (lambda (x) (+ (* x x x) x)) 1 6 100)  ; 1365/4
