
# AIFFEL Campus Online Code Peer Review Templete

- 코더 : 김영진
- 리뷰어 : 이혁희



## PRT(Peer Review Template)

[X] 1. 주어진 문제를 해결하는 완성된 코드가 제출되었나요?

문제에서 요구하는 최종 결과물이 출력되는 코드가 제출 되었습니다.
   
```
Using Comprenhension:
Nemo is swimming at 3 m/s
Dory is swimming at 5 m/s
Using Generator:
Nemo is swimming at 3 m/s
Dory is swimming at 5 m/s
```


[X] 2. 전체 코드에서 가장 핵심적이거나 가장 복잡하고 이해하기 어려운 부분에 작성된 주석 또는 doc string을 보고 해당 코드가 잘 이해되었나요?

핵심적인 부분에 이해하기 쉽게 주석이 잘 작성되어 있습니다.
    
> - 컴프리헨션을 이용해 리스트를 만든다는 것을 설명
> ```
>     fish = [f"{i['이름']} is swimming at {i['speed']} m/s" for i in f_li]   # fish_list를 인자로 준 변수 f_li의 요소 하나마다 f 스트링으로 key와 value를 받아서 출력한 다음 컴프리헨션으로 fish라는 리스트로 만듦
>     
>     for x in fish:  # fish 리스트 요소 하나마다 출력
>         print(x)
> ```
> 
> - yield 하는 것을 설명
> ```
>     for x in f_ls:  # fish_list를 인자로 준 변수 f_li의 요소 하나마다 yield를 써서 뽑음
>     yield f"{x['이름']} is swimming at {x['speed']} m/s"
>
> ```
> 
> - generator object를 생성하고 next 함수를 call하여 값을 불러옴을 설명
> ```
> gen = show_fish_movement_Generator(fish_list)   # 함수를 gen이라는 변수에 저장했음
> print(next(gen))    # next 함수로 반복적으로 출력함
> print(next(gen))    # next 함수로 반복적으로 출력함
> ```

[X] 3. 에러가 난 부분을 디버깅하여 문제를 “해결한 기록을 남겼거나” ”새로운 시도 또는 추가 실험을 수행”해봤나요?

별다른 문제가 발생하지 않아 기록이 없는 것 같습니다.



[X] 4. 회고를 잘 작성했나요?

회고 부분은 프로젝트 결과물에 대한 배운 점과 아쉬운 점, 느낀 점이 명확하게 기록되어 있습니다. 


[X] 5. 코드가 간결하고 효율적인가요?

- 코드가 간결하게 작성되었습니다. 특히 변수명을 길게 사용하지 않고도 가독성이 좋게 작성한 점이 훌륭합니다. 

- f스트링을 리스트 변수에 저장하여 print한 점이 훌륭합니다. 우리 조는 그 생각을 못해서 리스트를 print하는 함수를 따로 만들었습니다. 좋은 팁을 알게 되어 감사합니다.
```
    fish = [f"{i['이름']} is swimming at {i['speed']} m/s" for i in f_li]   # fish_list를 인자로 준 변수 f_li의 요소 하나마다 f 스트링으로 key와 value를 받아서 출력한 다음 컴프리헨션으로 fish라는 리스트로 만듦

```

- genrator의 결과를 출력하는 코드에서 next함수가 2번 호출되었습니다. 이런 경우, 물고기의 마릿수가 더 많아질 경우에는 앞의 2개만 출력되고, 물고기 1마리 이하인 경우에는 에러가 발생할 것입니다. 다음과 같이 for문을 이용하면 물고기의 마릿수가 변하는데 적응할 수 있을 것입니다.

```
### next를 두번 호출
gen = show_fish_movement_Generator(fish_list)   # 함수를 gen이라는 변수에 저장했음
print(next(gen))    # next 함수로 반복적으로 출력함
print(next(gen))    # next 함수로 반복적으로 출력함
```

```
### for문을 사용한 예
for message in show_fish_movement_comprehension(fish_list):
    print(message)

```


## 리뷰

코드가 전체적으로 간결하고 읽기 좋습니다.
저는 변수명, 함수명을 길게 쓰고 코드를 장황하게 만드는 경향이 있는데 이 코드를 보면서 간결하게 작성하도록 노력해야겠다는 생각을 했습니다. 감사합니다.
