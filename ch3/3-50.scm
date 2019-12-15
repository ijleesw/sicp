(define (stream-map proc . argstreams)
    (if (stream-null? (car argstreams))
        the-empty-stream
        (cons-stream (apply proc (map stream-car argstreams))
                     (apply stream-map (cons proc (map stream-cdr argstreams))))))

(define stream1 (stream 1 2 3))
(define stream2 (stream 40 50 60))
(define stream3 (stream 700 800 900))

(define res (stream-map + stream1 stream2 stream3))
res
(stream-car res)
(stream-car (stream-cdr res))
(stream-car (stream-cdr (stream-cdr res)))
