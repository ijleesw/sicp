(define (random-in-range l r)  ;; exclusive
    (+ l (random (- r l 0.0))))

(define (monte-carlo trials experiment)
    (define (iter trials-remaining trials-passed)
        (cond ((= trials-remaining 0)
               (/ trials-passed trials))
              ((experiment)
               (iter (- trials-remaining 1) (+ trials-passed 1)))
              (else
               (iter (- trials-remaining 1) trials-passed))))
    (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)
    (define (experiment)
        (let ((x (random-in-range x1 x2))
              (y (random-in-range y1 y2)))
            (P x y)))
    (monte-carlo trials experiment))

(define (P x y)
    (<= (+ (square (- x 5)) (square (- y 7))) (square 3)))

(+ (estimate-integral P 2 8 4 10 100000) 0.0)
