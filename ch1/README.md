# Summary (in Korean)

## 1.1 프로그램 짤 때 바탕이 되는 것

- 프로그래밍 언어의 3요소
  - primitive expression
  - means of combination
  - means of abstraction

- scheme은 내부적으로 substitution model(맞바꿈 계산법)로 계산한다.

- 두 가지 계산법
  - normal-order evaluation (정의대로 계산법)
  - applicative-order evaluation (인자값 먼저 계산법)
  - substitution model로 값이 제대로 나오는 procedure는 두 방법이 같은 값을 내뱉는다.

- if나 cond는 tail recursion을 지원한다.
  - new-if나 new-cond를 만들면 substitution 과정에서 if/cond를 날려버리지 않기 때문에 function recursion이 stack에 쌓인다.

## 1.2 프로시저와 프로세스

- Procedure vs Process
  - Procedure : 특정 일을 하기 위한 절차
    - Recursive procedure : 정의 내에서 자기 자신을 부르는 프로시저(함수)
  - Process : 절차가 만들어내는 (중간) 과정
    - Recursive process : 계산이 실제로 recursive하게 이뤄지는 프로세스

- Recursion vs Iteration
  - Linear recursive process : 실행기가 쥐어야 하는 정보의 크기가 n에 linear
  - Linear iterative process : 결과값을 구하는 데 거치는 단계 수가 n에 linear
    - Iterative procedure를 설계할 때에는 invariant를 찾는 게 도움된다.

## 1.3 High-order procedure(차수 높은 프로시저)로 요약하는 방법

- High-order procedure : 프로시저를 데이터처럼 (인자로 받거나 결과값으로 돌려주는 것) 사용하는 프로시저

- Haskell의 `foldr`, `foldl`, `foldl'`
  - `foldr (-) 10 [1,2,3]` -> `[1,2,3,10]`에 대해 우측부터 (-) 연산 tree 완성 후 apply -> -8
  - `foldl (-) 10 [1,2,3]` -> `[10,1,2,3]`에 대해 좌측부터 (-) 연산 tree 완성 후 apply -> 4
  - `foldl' (-) 10 [1,2,3]` -> `[10,1,2,3]`에 대해 좌측부터 (-) 연산 즉시 apply -> 4

- `foldl'`의 scheme 버전은 아래와 같다.
```scheme
(accumulate combiner null-value term a next b)
(filtered-accumulate combiner predicate null-value term a next b)
```

- Scheme을 쓰면 하려는 작업을 수학적으로 아름답게 표현 가능하다!
  - Naive한, x의 제곱근 구하기 : y와 x/y 사이에서 수렴해나간다.
  - 우아한, x의 제곱근 구하기 : f(y) = x/y의 fixed-point를 구한다.
  - 결국, (1) 하려는 작업의 일반화된 form을 먼저 구하고 (2) 그 form의 specialized version으로 현재 문제를 푸는 것.
```scheme
(define (sqrt x)
    (fixed-point (lambda (y) (/ x y)) 1.0))
```
