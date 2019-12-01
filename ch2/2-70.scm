(load "2-69.scm")

(define rock-tree (generate-huffman-tree '((A 2)
                                           (BOOM 1)
                                           (GET 2)
                                           (JOB 2)
                                           (NA 16)
                                           (SHA 3)
                                           (YIP 9)
                                           (WAH 1))))
(define song '(get a job
               sha na na na na na na na na
               get a job
               sha na na na na na na na na
               wah yip yip yip yip yip yip yip yip yip
               sha boom))

(equal? song (decode (encode song rock-tree) rock-tree))
