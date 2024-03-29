(define (accumulate op init seq)
    (if (null? seq)
        init
        (op (car seq) (accumulate op init (cdr seq)))))

(define (accumulate-n op init seqs)
    (if (null? (car seqs))
        ()
        (cons (accumulate op init (map car seqs))
              (accumulate-n op init (map cdr seqs)))))

(accumulate-n + 0 (list (list 1 2 3) (list 5 6 7) (list 4 8 12)))
