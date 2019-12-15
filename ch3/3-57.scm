(define fibs
    (cons-stream 0
                 (cons-stream 1
                              (add-stream fib (stream-cdr fib)))))

; Let a(i) be the number of additions to get fib(i) from fibs w/o memoization.
; It's easy to see that a(0) = 0, a(1) = 0, and a(i) = a(i-1) + a(i-2) + 1 where i >= 2.
; Then, a(3) = f(3) and a(4) > f(4), which means that a(i) > fib(i) where i >= 4.
; On one hand, fib(n) is exponential to n.
; On the other hand, let b(0) = 1 and b(i) = 2b(i-1) where i >= 1.
; Then, b(i) > a(i) for all positive i while b(n) is also exponential to n.
; Therefore, a(n) is exponential to n as fib(n) < a(n) < b(n).
