;; 1. Because it's like popping one element from a stack, and pushing it to another stack. Then the order is reversed.
;; 2. (cons (list a1 a2 .. ak) a(k+1)) is not (a1 a2 .. a(k+1)); it's ((a1 a2 .. ak) . a(k+1))
