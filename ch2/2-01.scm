(define (make-rat n d)
    (let ((g ((if (< d 0) - +) (gcd n d))))  ; got this idea from http://community.schemewiki.org/?sicp-ex-2.1
        (cons (/ n g) (/ d g))))

(make-rat 6 8)
(make-rat -6 8)
(make-rat 6 -8)
(make-rat -6 -8)
