(define (for-each proc li)
    (cond ((not (null? li))
           (proc (car li)) (for-each proc (cdr li)))))

(for-each (lambda (x) (newline) (display x))
          (list 1 3 5 7 9))
