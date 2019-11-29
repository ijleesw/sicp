;; a.
;; Same; both are inorder traversal.

;; b.
;; tree->list-1 : T(n) = 1 + 2*T(n/2) + O(n/2) where O(n/2) from append procedure.
;;                Thus it is O(n log n)
;; tree->list-2 : T(n) = 1 + 2*T(n/2)
;;                Thus it is O(n)
