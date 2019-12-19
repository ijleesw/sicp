(define (integers-from n) (cons-stream n (integers-from (+ n 1))))
(define integers (integers-from 0))
(define (display-stream-until s n)
    (if (or (= n 0) (stream-null? s))
        'done
        (begin (newline) (display (stream-car s)) (display-stream-until (stream-cdr s) (- n 1)))))

(define (add-streams . args) (apply stream-map (cons + args)))
(define (scale-stream s factor) (stream-map (lambda (x) (* x factor)) s))

;;;;;;;;;;;;; 3.77

(define (integral delayed-integrand init-val dt)
    (cons-stream init-val
                 (let ((integrand (force delayed-integrand)))
                     (if (stream-null? integrand)
                         the-empty-stream
                         (integral (stream-cdr integrand)
                                   (+ (* dt (stream-car integrand))
                                      init-val)
                                   dt)))))

;;;;;;;;;;;;; 3.78

(define (integral delayed-integrand init-val dt)
    (define int
        (cons-stream init-val
                     (add-streams (scale-stream (force delayed-integrand) dt)
                                 int)))
    int)

(define (solve-2nd a b dt y0 dy0)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy (add-streams (scale-stream dy a) (scale-stream y b)))
    y)

(stream-ref (solve-2nd 1 0 0.0001 1 1) 10000)  ; e
(stream-ref (solve-2nd 0 -1 0.0001 1 0) 10472)  ; cos pi/3 = 0.5
(stream-ref (solve-2nd 0 -1 0.0001 0 1) 5236)  ; sin pi/6 = 0.5

;;;;;;;;;;;;; 3.79

(define (solve-2nd-generic f dt y0 dy0)
    (define y (integral (delay dy) y0 dt))
    (define dy (integral (delay ddy) dy0 dt))
    (define ddy (stream-map f dy y))
    y)

(stream-ref (solve-2nd-generic (lambda (dy y) (* -1 y)) 0.0001 1 0) 10472)  ; cos pi/3 = 0.5

;;;;;;;;;;;; 3.80

(define (RLC R L C dt)
    (lambda (vc0 il0)
        (define vc (integral (delay dvc) vc0 dt))
        (define il (integral (delay dil) il0 dt))
        (define dvc (scale-stream il (/ -1 C)))
        (define dil (add-streams (scale-stream vc (/ 1 L))
                                 (scale-stream il (/ (* -1 R) L))))
        (stream-map cons vc il)))

(define RLC1 (RLC 1 1 0.2 0.1))
(display-stream-until (RLC1 10 0) 30)

;;;;;;;;;;;;;;;;;;;;;;;;;;; 3.81

(define (random-next prev) (+ prev 1))

; reset -> tail recursion.
; generate -> cons-stream, so that the stream can stop.
(define (generator seed reqs)
    (let ((cur-req (stream-car reqs))
          (next-req (stream-cdr reqs)))
        (cond ((eq? cur-req 'generate)
               (cons-stream seed (generator (random-next seed) next-req)))
              ((eq? cur-req 'reset)
               (generator (stream-car next-req) (stream-cdr next-req)))
              (else "undefined request -- GENERATOR" cur-req))))

(define requests (stream 'generate 'generate 'reset 0
                         'generate 'generate 'generate 'reset 0 'reset 0
                         'generate 'reset 2
                         'generate 'generate
                         the-empty-stream))

(define rand-seq (generator 0 requests))

(display-stream-until rand-seq 15)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 3.82

(define (P x y)
    (<= (+ (square (- x 5)) (square (- y 7))) (square 3)))

(define (estimate-integral P x1 x2 y1 y2)
    (let ((x (+ (random (- x2 x1)) x1))
          (y (+ (random (- y2 y1)) y1)))
        (cons-stream (P x y)
                     (estimate-integral P x1 x2 y1 y2))))

(define (monte-carlo experiment-stream passed failed)
    (define (next passed failed)
        (cons-stream (/ passed (+ passed failed))
                     (monte-carlo (stream-cdr experiment-stream) passed failed)))
    (if (stream-car experiment-stream)
        (next (+ passed 1) failed)
        (next passed (+ failed 1))))

(define P-monte-carlo (monte-carlo (estimate-integral P 2.0 8.0 4.0 10.0) 0 0))
(* 4.0 (stream-ref P-monte-carlo 100000))  ; ~= pi
