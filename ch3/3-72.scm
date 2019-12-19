(load "3-71.scm")

(define (sum-squares li) (apply + (map square li)))

(define integers (integers-from 1))
(define sum-square-ordered-pairs
    (weighted-pairs sum-squares integers integers))

(define pseudo-ramanujan
    (consecutive-elts-from-stream sum-square-ordered-pairs sum-squares 3))
(display-stream-until 10 pseudo-ramanujan)
