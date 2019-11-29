(define (accumulate op init seq)
    (if (null? seq) init (op (car seq) (accumulate op init (cdr seq)))))

(define (enumerate-interval l r)
    (if (> l r) () (cons l (enumerate-interval (+ l 1) r))))

(define (flatmap proc seq)
    (accumulate append () (map proc seq)))

(define (remove k seq)
    (filter (lambda (x) (not (= x k))) seq))

(define (permutations seq)
    (if (null? seq)
        (list ())
        (flatmap (lambda (i)
                         (map (lambda (subseq)
                                      (cons i subseq))
                              (permutations (remove i seq))))
                 seq)))

(define (ascending-triples n)
    (flatmap (lambda (i)
                     (flatmap (lambda (j)
                                      (map (lambda (k)
                                                   (list i j k))
                                           (enumerate-interval (+ j 1) n)))
                              (enumerate-interval (+ i 1) n)))
             (enumerate-interval 1 n)))

(define (sum-triples s n)
    (flatmap permutations
             (filter (lambda (seq)
                             (= s (accumulate + 0 seq)))
                     (ascending-triples n))))

(sum-triples 8 4)
