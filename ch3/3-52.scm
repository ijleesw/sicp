(load "stream-base.scm")

; With memoization: trivial.
; Note: Every side-effect occurs only once.

; Without memoization:
; Note: `prev-sum` means the value of `sum` before addition. It's not an additional variable.

(define sum 0)

(define (accum x) (set! sum (+ x sum)) sum)

(define seq
    (stream-map accum (stream-enumerate-interval 1 20)))
; `seq` is (1, #promise), `sum` is 1

(define y (stream-filter even? seq))
; `y` is (6, #promise)
; local (stream-enum-intv) inside `seq` is #promise, which will start from 4
; `seq` is #promise, which depends on (stream-enum-intv)
; `sum` is 6 (= `prev-sum` + 2 + 3) -- 1 omitted because it was evaluated when `seq` was defined.

(define z
    (stream-filter (lambda (x) (= (remainder x 5) 0)) seq))
; `z` is (10, #promise)
; local (stream-enum-intv) inside `seq` is #promise, which will start from 5
; `seq` is #promise, which depends on (stream-enum-intv)
; `sum` is 15 (= `prev-sum` + 2 + 3 + 4)  -- 1 omitted with the same reason

(stream-ref y 7)
; local (stream-enum-intv) starts from 4, making `seq` starts from 19 = `prev-sum` + 4
; `seq` becomes (19, 24(= 19 + 5), 30(= 24 + 6), 37(= 30 + 7), 45, 54, 64, ..., 162, #promise)
; `y` becomes (6, 24, 30, 54, 64, 100, 114, 162, #promise)
; `sum` is 162, which is `prev-sum` + 4 + 5 + 6 + ... + 17 -- 1~3 omitted because local (stream-enum-intv) starts from 4.
; If (stream-ref y 7) is called again, then local (stream-enum-intv) starts again from 4, but due to difference in `prev-sum`, `seq` and `y` will be different, as well as `sum`.

(display-stream z)
; local (stream-enum-intv) starts from 5, making `seq` starts from 167 = `prev-sum` + 5
; `seq` becomes (167, 173(= 167 + 6), 180(= 173 + 7), 188, 197, ..., 362)
; `z` becomes (15, 180, 230, 305)
; `sum` is 362, which is `prev-sum` + 5 + 6 + ... + 20 -- 1~4 omitted with the same reason.
; If (display-stream z) is called again, then local (stream-enum-intv) starts again from 5, but due to difference in `prev-sum`, `seq` and `z` will be different, as well as `sum`.
