#|
It's because Louis's procedure calculates (queen-cols (k-1)) k times per each k, instead of calculating it once per each k.


Let T(k) be the computations required for (queen-cols k).
Let f(k) be the number of results of (queens-cols k)

2-42's approach:
T(k) = T(k-1) + nf(k-1)

T(2) = T(1) + nf(1)
T(3) = T(2) + nf(2) = T(1) + nf(1) + nf(2)
T(4) = T(3) + nf(3) = T(1) + nf(1) + nf(2) + nf(3)
...
T(k) = T(1) + n(f(1) + ... + f(k-1))

Louis's approach:
T(k) = nT(k-1) + nf(k-1)

T(2) = nT(1) + nf(1)
T(3) = nT(2) + nf(2) = n^2 T(1) + n^2 f(1) + nf(2)
T(4) = nT(3) + nf(3) = n^3 T(1) + n^3 f(1) + n^2 f(2) + nf(3)
...
T(k) = n^(k-1) T(1) + (\sum_{i=1}^{k-1} n^(k-i) f(i))

Since there's no known general formula of f(k), T_{Louis}(k) / T_{2-42}(k) cannot be generalized..
|#
