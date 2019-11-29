(define (accumulate op init seq)
    (if (null? seq)
        init
        (op (car seq) (accumulate op init (cdr seq)))))

(define (flatmap proc seq)
    (accumulate append () (map proc seq)))

(define (enumerate-interval l r)
    (if (> l r)
        ()
        (cons l (enumerate-interval (+ l 1) r))))

(define (unique-pairs n)
    (flatmap (lambda (i)
                     (map (lambda (j) (list i j)) (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))

(unique-pairs 5)

(define (prime-sum-pairs n)
    (map make-pair-sum
         (filter prime-sum? (unique-pairs n))))
