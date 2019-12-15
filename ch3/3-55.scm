(define (add-streams s1 s2) (stream-map + s1 s2))
(define (integers-from n) (cons-stream n (integers-from (+ n 1))))

; ps(0) = s(0)
; ps(i) = s(i) + ps(i-1) where i >= 1
(define (partial-sums s)
    (define ps (cons-stream (stream-car s) (add-streams (stream-cdr s) ps)))
    ps)

; An elegant solution by lertecc from http://community.schemewiki.org/?sicp-ex-3.55
; (cons-stream 0 ps) delays `ps` itself by one index, as 0 is an identity of addition.
(define (partial-sums s)
    (define ps (add-streams s (cons-stream 0 ps)))
    ps)

(define ps (partial-sums (integers-from 1)))
(stream-ref ps 0)
(stream-ref ps 1)
(stream-ref ps 2)
(stream-ref ps 1000)
