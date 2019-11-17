(define (tree-map proc tree)
    (map (lambda (subtree)
          (if (not (pair? subtree))
              (proc subtree)
              (tree-map proc subtree)))
         tree))

(define t (list 1 2 3 (list 4 5 (list 6 7 8) 9 10 (list 11 12) 13) 14))
(tree-map square t)
