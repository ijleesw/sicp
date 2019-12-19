(define (integers-from n)
    (cons-stream n (integers-from (+ n 1))))

(define (display-stream-until n s)
    (if (= n 0) 'done
        (begin (newline) (display (stream-car s)) (display-stream-until (- n 1) (stream-cdr s)))))

(define (merge-weighted weight s1 s2)
    (cond ((stream-null? s1) s2)
          ((stream-null? s2) s1)
          (else (if (< (weight (stream-car s1)) (weight (stream-car s2)))
                    (cons-stream (stream-car s1) (merge-weighted weight (stream-cdr s1) s2))
                    (cons-stream (stream-car s2) (merge-weighted weight s1 (stream-cdr s2)))))))

(define (weighted-pairs weight s1 s2)
    (cons-stream (list (stream-car s1) (stream-car s2))
                 (merge-weighted weight
                                 (stream-map (lambda (x) (list (stream-car s1) x)) (stream-cdr s2))
                                 (weighted-pairs weight (stream-cdr s1) (stream-cdr s2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (consecutive-elts-from-stream s aggr-fn n)
    (define (skip-same-elts s val)
        (if (equal? (aggr-fn val) (aggr-fn (stream-car s)))
            (skip-same-elts (stream-cdr s) val)
            s))

    (define (build-same-elts-list from to)
        (let ((first (stream-car from))
              (next (stream-cdr from)))
        (cond ((null? to)
               (build-same-elts-list next (list first)))
              ((equal? (aggr-fn first) (aggr-fn (car to)))
               (build-same-elts-list next (cons first to)))
              (else to))))

    (if (equal? (aggr-fn (stream-car s))
                (aggr-fn (stream-ref s (- n 1))))
        (cons-stream (cons (aggr-fn (stream-car s))
                           (build-same-elts-list s ()))
                     (consecutive-elts-from-stream (skip-same-elts s (stream-car s)) aggr-fn n))
        (consecutive-elts-from-stream (skip-same-elts s (stream-car s)) aggr-fn n)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (cube x) (* x x x))
(define (sum-cubes li) (apply + (map cube li)))

(define integers (integers-from 1))
(define sum-cube-ordered-pairs
    (weighted-pairs sum-cubes integers integers))

(define ramanujan (consecutive-elts-from-stream sum-cube-ordered-pairs sum-cubes 2))
(display-stream-until 10 ramanujan)
