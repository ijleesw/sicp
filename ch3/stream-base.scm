; `cons-stream` store second part in a procedure form.
; `stream-cdr` evaluated the stored procedure form, which is usually the original procedure.
; Thus, for-each, map, filter, ref procedures for the stream works just like those for the list
;   -- they use tail-recursion.

; use tail-recursion -- constant memory consumption
(define (stream-ref s n)
    (if (= n 0)
        (stream-car s)
        (stream-ref (stream-cdr s) (- n 1))))

; store (apply stream-map (cons proc (...))) in a procedure form
;   -- stream-cdr evokes stored procedure form only, exploiting tail-recursion.
(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream (apply proc (map stream-car argstreams))
                     (apply stream-map (cons proc (map stream-cdr argstreams))))))

; trivially tail-recursion
(define (stream-for-each proc s)
    (if (stream-null? s)
        'done
        (begin (proc (stream-car s)) (stream-for-each proc (stream-cdr s)))))

; tail-recursion
(define (display-stream s)
    (stream-for-each (lambda (x) (newline) (display x)) s))

; tail-recursion
(define (stream-enumerate-interval low high)
    (if (> low high)
        the-empty-stream
        (cons-stream low (stream-enumerate-interval (+ low 1) high))))

; tail-recursion due to the same reason as stream-map
(define (stream-filter pred stream)
    (cond ((stream-null? stream) the-empty-stream)
          ((pred (stream-car stream))
           (cons-stream (stream-car stream)
                        (stream-filter pred (stream-cdr stream))))
          (else
           (stream-filter pred (stream-cdr stream)))))

(define (memo-proc proc)
    (let ((already-run? #f)
          (result #f))
        (lambda ()
            (if (already-run?)
                result
                (begin (set! result (proc))
                       (set! already-run? #t)
                       result)))))

(define (add-streams s1 s2) (stream-map + s1 s2))
(define (scale-stream s factor) (stream-map (lambda (x) (* x factor)) s))
