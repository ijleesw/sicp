# Summary

- 시스템을 바라보는 관점 2가지
  1. 시스템은 시간에 따라 state가 변하는 object들로 이루어져 있다.
     -> Environment Model of Computation
  2. 시스템은 stream처럼 흘러가는 끝없는 정보를 처리한다.
     -> Delayed Evaluation (시간 흐름과 컴퓨터 계산 차례는 관계가 없기 때문)

## 3.1 Assignment(덮어쓰기)와 Local State(갇힌 상태)

- Functional Programming : 덮어쓰기 없이 프로그램을 짜는 방식
  - referential transparent하다. (substitution 하더라도 값이 달라지지 않는다.)
  - delayed evaluation을 적용할 수 있다.

- Imperative Programming : 덮어쓰기처럼 명령을 내려 프로그램을 짜는 방식
  - substitution으로 설명할 수 없다.
  - 따라서 delayed evaluation을 적용할 수 없다.

## 3.2 The Environment Model of Evaluation

- An environment is a sequence of frames.
- Each frame is a table of bindings, which associate variable names with their corresponding values. Each frame also has a pointer to its enclosing environment.
- The value of a variable with respect to an environment is the value given by the binding of the variable in the frist frame in the envrionment that contains a binding for that variable.

- define 과정
  1. env의 frame에 name을 등록한다.
  2. body에서 필요한 apply를 다 한다.
  3. 결과가 value면 이름 옆에 값을 기입한다.
  4. 결과가 procedure면 name -> (code ptr, env ptr)가 되게 한다.

- apply 과정
  1. 현재 env에서부터 procedure name을 찾는다.
  2. name이 가리키는 env ptr의 pointing env를 base로 하는 새 env를 만든다. 새 env 안에는 param을, 옆에는 body를 적는다.
  3. body의 define은 새 env의 frame으로 등록된다.
  4. body가 value나 primitive/compiled procedure면 env를 pop하고 결과값을 return한다.
  5. body가 compound procedure인데 apply가 가능하면 현재 env를 기준으로 다시 1.로 돌아간다.
  6. body가 compound procedure인데 apply가 불가능하면 env와 옆에 적은 body가 결과값이 된다.

## 3.3 Modeling with Mutable Data

1. 매번 새로운 pair object가 생성된다. list를 만들면 item 수만큼 pair가 만들어진다.
2. 기존의 proc들(! 없는 것들)로는 한 번 생성된 pair obj.를 건드릴 수 없다.
   - 따라서 interpreter 바깥쪽에서는 `equal?`의 결과가 #t인 것들이 _사실상 같다_.
```scheme
(define x (cons 1 ()))
(define y1 (cons x x))
(define y2 (cons '(1) '(1)))    ;; 둘의 차이를 느낄 수 없다.
```
3. 내부적으로 pair object는 ptr의 pair이다. 사실 모든 object는 ptr이라고 보면 된다.
   - 위의 예에서 x는 ptr의 pair를 가리키는 pair이고, (car x)는 1이라는 symbol을 가리키는 ptr, (cdr x)는 symbol ()을 가리키는 ptr이다.
4. eq?는 ptr이 같은지 확인하는 proc이다.
   - 따라서 set!이 있는 interpreter 세계에서는 `eq?`의 결과가 #t인 것들이 _사실상 같다_.
```scheme
(equal? (list 1 2) (list 1 2))  ;; #t
(eq? (list 1 2) (list 1 2))     ;; #f
```
5. symbol은 global하게 1개씩만 존재한다.
```scheme
(eq? () ())     ;; #t
(eq? '1 1)      ;; #t
(eq? 'a 'A)     ;; #t
(eq? 'a 'aa)    ;; #f
```

## 3.4 Concurrency : Time Is of the Essence

- x = x'을 가져오고, 조작하고, 대입하는 세 과정으로 쪼개서 interleaved되는 상황을 다룬다.
- 그리고 그걸 해결하기 위해 mutex를 소개한다.

- make-serializer의 내부 구현을 보면, mutex를 잡고 apply를 하고 mutex를 놓는다.
  - 이때 mutex를 잡은 상태에서, mutex로 보호받는 variable을 잘못 짜인 procedure가 acquire 없이 접근 할 수 있다! (Exercise 3.40 참고)

- 나머지는 OS 수업에서 많이 다뤘으므로 생략한다.

## 3.5 Streams

- Stream
  - 이론상 :
  - 구현상 : pair의 second를 procedure form으로 바꿔서 저장한 list. second를 원할 때 procedure form을 evaluate하여 값을 가져온다 (call-on-need).

### 3.5.1 Streams Are Delayed Lists

- `cons-stream` : first는 value로, second는 promise로 바꿔 delay시킨 뒤 pair를 만들어준다.
- `stream-car` : stream의 first는 value이므로 `car`과 동일하게 값을 가져온다.
- `stream-cdr` : promise인 second를 `force`로 계산시켜서 가져온다. 이때 second의 first만 값이 되고, second의 second는 여전히 promise이다.
- `delay` : (delay x) -> (lambda () (x))로 바뀐다. 즉, procedure form으로 만들어 계산되지 않도록 해준다.
- (optimized) `delay` : proc을 받아서 (procedure form, already-run?, result)의 tuple을 만들어 보관한다. 첫 방문때 procedure form을 evaluate하여 result에 저장하고 already-run?을 `#t`로 바꾼다. 그 이후로는 result만 내뱉는다.
- `force` : (define (force x) ()). 즉, procedure form을 받아서 evaluate 해준다.

- Note : `delay`는 keyword이고, keyword는 procedure가 아니다.
  - (procedure x)는 x를 미리 계산한 뒤에 procedure를 적용한다.
  - 근데 그러면 (define (delay x) (lambda () (x))) 라 하더라도 x가 먼저 계산된 뒤에 lambda에 씌워진다.
  - 따라서 keyword를 두어 (preprocessor처럼) procedure 계산 전에 form을 바꿔주도록 한다.
    - let을 lambda 꼴로 바꿔주고 delay를 lambda 꼴로 바꿔주면 x를 계산하지 않고도 원하는 form을 만들 수 있다.
- Note : `cons`는 procedure이지만 `cons-stream`은 keyword이다.
  - `cons`는 evaluation을 다 해도 상관 없지만 `cons-stream`은 second의 evaluation을 하면 안 되기 때문에 procedure가 될 수 없다.

- `delay`에 memoization을 넣으면 모든 side-effect는 한 번만 일어난다.
  - 동일한 base stream object를 여러 object가 procedure 내에서 공유할 때, 공유하는 object들끼리 interleaved 되어서 여러번 값이 evaluate 되더라도 base object가 한 번만 evaluate되기 때문에 값은 항상 동일하다. (Exercise 3.53 참고)

### 3.5.2 Infinite Streams

```scheme
(define fibs
    (cons-stream 0 (cons-stream 1 (add-stream fib (stream-cdr fib)))))
````
- 위 프로그램은 아래와 같이 해석된다:
  - fibs(0) = 0
  - fibs(1) = 1
  - fibs(i) = fibs(i-2) + fibs(i-1) where i >= 2

```scheme
(define exp-series (cons-stream 1 (integrate-series exp-series)))
(define (mul-series s1 s2)
    (cons-stream (* (stream-car s1) (stream-car s2))
                 (add-streams (scale-stream (stream-cdr s1) (stream-car s2))
                              (mul-series s1 (stream-cdr s2)))))
(display-stream-until 20 (mul-series exp-series exp-series))
```
- infinite stream은 위와 같이 power series를 다루는 데에 유용하게 사용할 수 있다.
