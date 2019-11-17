(define (make-mobile l r) (list l r))
(define (make-branch len struct) (list len struct))

;; a.
(define (left-branch m) (car m))
(define (right-branch m) (cadr m))
(define (branch-length b) (car b))
(define (branch-structure b) (cadr b))

;; b.
(define (total-weight m)    ;; m should be mobile
    (if (not (pair? m))
        m
        (+ (branch-structure (left-branch m))
           (branch-structure (right-branch m)))))

;; c.
;; Defined [ sum-balanced?-pair :: mobile |-> (sum, balanced?) ] instead of using total-weight to reduce recursions.
(define (balanced? m)       ;; m should be mobile
    (define (sum-balanced?-pair m)
        (if (not (pair? m))
            (cons m #t)
            (let ((left (sum-balanced?-pair (branch-structure (left-branch m))))
                  (right (sum-balanced?-pair (branch-structure (right-branch m)))))
                (cons (+ (car left)
                         (car right))
                      (and (cdr left)
                           (cdr right)
                           (= (* (branch-length (left-branch m)) (car left))
                              (* (branch-length (right-branch m)) (car right))))))))
    (cdr (sum-balanced?-pair m)))

;; d.
;; Modifying selectors is sufficient.

;; test cases from http://community.schemewiki.org/?sicp-ex-2.29
(define a (make-mobile (make-branch 2 3) (make-branch 2 3)))
(total-weight a)

(define d (make-mobile (make-branch 10 a) (make-branch 12 5)))
(balanced? d)
