(define m (list (list 1 1 1 1) (list 0 1 1 1) (list 0 0 1 1)))

(define (accumulate op init seq)
    (if (null? seq)
        init
        (op (car seq) (accumulate op init (cdr seq)))))

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        ()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))

(define (dot-product v w)
    (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
    (map (lambda (row) (dot-product row v)) m))

(define (transpose m)
    (accumulate-n cons () m))

(define (matrix-*-matrix m1 m2)
    (let ((cols (transpose m2)))
        (map (lambda (row) (matrix-*-vector cols row)) m1)))
