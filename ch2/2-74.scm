(define void ())

;; a.
(define (get-record department name)
    (let ((proc (get 'record department)))
        (if (not proc)
            #f
            (proc name))))
;; Each department's file should be like a table of RDBMS; record as a row, name, address, salary as columns.
;; A lookup table for the retrieval of procedure should be provided.

;; b.
(define (get-salary department name)
    (let ((proc (get 'salary department)))
        (if (not proc)
            #f
            (proc name))))

;; c.
(define (find-employee-list department-list name)
    (if (null? department-list)
        #f
        (or (get-record (car department-list) name)
            (find-employee-list (cdr department-list name)))))

;; d.
;; The new company's departments' retrieval procedures should be added to the lookup table.
