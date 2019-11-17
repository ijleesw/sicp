;; This version of `accumulate` accumulates from right to left.
(define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))

(define (map p sequence)
    (accumulate (lambda (x y) (cons x y)) () sequence))

(define (append seq1 seq2)
    (accumulate cons seq2 seq1))

(define (length sequence)
    (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define s1 (list 1 3 5 7 9))
(define s2 (list 2 4 6 8 10))

(map square s1)
(append s1 s2)
(length s1)
