;; (magnitude z) calls (apply-generic 'magnitude (list z)), which calls (get 'magnitude 'complex), which returns #f.
;; After adding additional definitions to complex package, (get 'magnitude 'complex) calls (apply-generic 'magnitude (list (cdr z))), which calls (get 'magnitude 'rectangular), which returns a local procedure magnitude, which was defined in (install-rectangular-package).
