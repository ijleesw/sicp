;; deque is represented as (front-item rear-item)
;; each item is stored as (value next prev)

(define (make-deque) (list () ()))
(define (front-item-deque dq) (car dq))
(define (rear-item-deque dq) (cadr dq))
(define (set-front-item-deque! dq new-ptr) (set-car! dq new-ptr) #t)
(define (set-rear-item-deque! dq new-ptr) (set-car! (cdr dq) new-ptr) #t)

(define (make-item value next prev) (list value next prev))
(define (value-item item) (car item))
(define (next-item item) (cadr item))
(define (prev-item item) (caddr item))
(define (set-value-item! item value) (set-car! item value))
(define (set-next-item! item next) (set-car! (cdr item) next))
(define (set-prev-item! item prev) (set-car! (cddr item) prev))

(define (empty-deque? dq)
    (null? (front-item-deque dq)))
(define (front-deque dq)
    (if (empty-deque? dq)
        (error "deque is empty -- FRONT-DEQUE")
        (value-item (front-item-deque dq))))
(define (rear-deque dq)
    (if (empty-deque? dq)
        (error "deque is empty -- REAR-DEQUE")
        (value-item (rear-item-deque dq))))

(define (front-insert-deque! dq value)
    (if (empty-deque? dq)
        (let ((new-item (make-item value () ())))
            (set-front-item-deque! dq new-item)
            (set-rear-item-deque! dq new-item) #t)
        (let ((new-item (make-item value (front-item-deque dq) ())))
            (set-prev-item! (front-item-deque dq) new-item)
            (set-front-item-deque! dq new-item))))
(define (rear-insert-deque! dq value)
    (if (empty-deque? dq)
        (let ((new-item (make-item value () ())))
            (set-front-item-deque! dq new-item)
            (set-rear-item-deque! dq new-item) #t)
        (let ((new-item (make-item value () (rear-item-deque dq))))
            (set-next-item! (rear-item-deque dq) new-item)
            (set-rear-item-deque! dq new-item))))

(define (front-delete-deque! dq)
    (if (empty-deque? dq)
        (error "deque is empty -- FRONT-DELETE-DEQUE!")
        (begin (set-front-item-deque! dq (next-item (front-item-deque dq)))
               (if (null? (front-item-deque dq))
                   (begin (set-rear-item-deque! dq ()) #t)
                   (begin (set-prev-item! (front-item-deque dq) ()) #t)))))
(define (rear-delete-deque! dq)
    (if (empty-deque? dq)
        (error "deque is empty -- REAR-DELETE-DEQUE!")
        (begin (set-rear-item-deque! dq (prev-item (rear-item-deque dq)))
               (if (null? (rear-item-deque dq))
                   (begin (set-front-item-deque! dq ()) #t)
                   (begin (set-next-item! (rear-item-deque dq) ()) #t)))))

;; test 1
(define dq (make-deque))
(empty-deque? dq)
(front-delete-deque! dq)
(rear-delete-deque! dq)
(front-insert-deque! dq 2)
(empty-deque? dq)

;; test 2
(define dq (make-deque))
(front-insert-deque! dq 2)
(front-delete-deque! dq)
(front-insert-deque! dq 2)
(rear-delete-deque! dq)
(front-insert-deque! dq 2)
(front-deque dq)
(rear-deque dq)
(front-delete-deque! dq)

;; test 3
(define dq (make-deque))
(rear-insert-deque! dq 2)
(rear-delete-deque! dq)
(front-insert-deque! dq 2)
(rear-delete-deque! dq)
(rear-insert-deque! dq 2)
(front-deque dq)
(rear-deque dq)
(rear-delete-deque! dq)

;; test 4
(define dq (make-deque))
(front-insert-deque! dq 3)
(rear-insert-deque! dq 1)
(front-deque dq)
(rear-deque dq)
(front-insert-deque! dq 4)
(front-insert-deque! dq 5)
(rear-insert-deque! dq 2)
(front-insert-deque! dq 6)
(front-deque dq)
(front-delete-deque! dq)
(front-deque dq)
(front-delete-deque! dq)
(front-deque dq)
(front-delete-deque! dq)
(front-deque dq)
(front-delete-deque! dq)
(front-deque dq)
(front-delete-deque! dq)
(front-deque dq)
(front-delete-deque! dq)
