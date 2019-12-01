(define (foldr op init seq) (if (null? seq) init (op (car seq) (foldr op init (cdr seq)))))
(define (foldl op init seq) (if (null? seq) init (foldl op (op init (car seq)) (cdr seq))))
(define (foldl-1st-res op init seq) (if (or (null? seq) (not init)) init (foldl op (op init (car seq)) (cdr seq))))

(define (apply-list procs args)
    (if (null? procs) () (cons ((car procs) (car args)) (apply-list (cdr procs) (cdr args)))))

(define (identity x) x)

(define (make-pairs-from-list li)
    (map (lambda (x)
                 (map (lambda (y)
                              (list x y))
                      li))
         li))
;; (make-pairs-from-list '(1 2 3 4))

(define (apply-generic op . args)
    (define (no-method-error arg)
        (error "No method for these types -- APPLY-GENERIC" arg))

    (define (all-types-same? types)
        (not (null? (filter (lambda (pair) (not (eq? (car pair) (cadr pair))))
                            (foldr append () (make-pairs-from-list types))))))

    ;; result value if succeeded in coercion; #f otherwise
    (define (apply-generic-coercion op types args)
        ;; coercion-list : ((identity t1->t2 t1->t3) (t2->t1 identity t2->t3) (t3->t1 t3->t2 identity))
        (let ((coercion-lists (filter (lambda (coercion-list)
                                              (not (memq #f coercion-list)))
                                      (map (lambda (type-pairs)
                                                   (map (lambda (type-pair)
                                                                (if (eq? (car type-pair) (cadr type-pair))
                                                                    identity
                                                                    (get-coercion (car type-pair) (cadr type-pair))))
                                                type-pairs)))
                                           (make-pairs-from-list types))))
            ;; coerced-args-lists : ((arg1 t1-arg2 t1-arg3) (t2-arg1 arg2 t2-arg3) (t3-arg1 t3-arg2 arg3))
            (let ((coerced-args-lists (map (lambda (coercion-list)
                                                   (apply-list coercion-list args))
                                           coercion-lists)))
                (foldl-1st-res (lambda (prev-res coerced-args)
                                       (or prev-res (apply apply-generic (cons op coerced-args))))
                               #f
                               coerced-args-lists))))

    (let ((types (map type-tag args)))
        (let ((proc (get op types)))
            (if proc
                ;; found appropriate procedure
                (apply proc (map contents args))
                ;; failed to find appropriate procedure
                (if (all-types-same? types)
                    ;; all types are the same; error
                    (no-method-error (list op types))
                    ;; different types exist; this part cannot be entered twice during recursion due to filter method in apply-generic-coercion.
                    (let ((coerced-res (apply-generic-coercion op types args)))
                        (if coerced-res
                            coerced-res
                            (no-method-error (list op types)))))))))
