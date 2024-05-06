[Simple app state management](https://docs.flutter.dev/data-and-backend/state-mgmt/simple)

# 1. State

[[Flutter] Stateless & Stateful 알아보기](https://noguen.tistory.com/24)

[[Flutter] State(상태)를 밥아저씨가 설명하는 것처럼 쉽게 알아보기](https://velog.io/@tmdgks2222/Flutter-State)

State란 위젯이 빌드될 때 동기적으로 읽을 수 있는 정보이자 위젯의 생명주기가 끝나기 전까지 변경될 수 있는 정보이다.

Flutter에서는 이를 두 가지 종류로 나눌 수 있다.

1. AppData
2. WidgetData

## AppData

앱 전반에서 사용되는 데이터로, 변경점이 생기면 다른 페이지들에서도 변경된 내용을 보여줘야 한다.

## WidgetData

위젯에서 사용되는 데이터로, 페이지들에서 필수적으로 변경하지 않아도 된다.

## Stateless

Stateless는 State가 없는 위젯이 아니다. 내부적으로 상태를 가지고 있긴 하지만 값을 변경할 수 없는 것이다. 즉, 상태가 변하지 않는 것이다.

새로고침이 없는 위젯이라고 할 수 있다.

## Stateful

Stateful 위젯은 상태가 존재하는 위젯으로, 내부적으로 상태가 변경되면 그에 맞게 화면을 다시 그려 변경된 부분을 위젯에 반영한다.

새로고침이 있는 위젯이다.

### initState()

위젯이 생성된 후 State 객체가 생성될 때 호출되는 메소드이고, 처음 한 번만 호출된다.

### build()

build() 메소드로 위젯이 그려지며, 상태가 변경될 때마다 호출된다.

### setState()

State 객체의 상태가 변경되었다는 것을 프레임워크에 알리는 메소드로, 위젯을 다시 그려준다.

</br>
</br>

# 2. 상태관리 툴

## Provider

[[Flutter] Provider로 앱 상태 관리하기](https://eunjin3786.tistory.com/255)

Provider는 Flutter에서 상태 관리를 쉽게 할 수 있도록 도와주는 패키지이다.

Flutter에서는 상태를 위젯 외부에서 변경하는 방식은 유지보수가 어려워지므로, 이 방식 대신 상태가 변경될 때마다 새로운 위젯을 생성하는 것이 좋다.

상태에 접근하는 방법으로는 콜백을 사용하는 것이 일반적이지만 여러 곳에서 상태를 수정해야 하는 경우에는 콜백을 계속 전달해야 하므로 비효율적이다.

따라서 Flutter에는 자식 위젯 뿐만 아니라 하위 모든 위젯에 데이터 및 서비스를 제공할 수 있는 메커니즘이 있는데, 이 중 하나가 **provider** 패키지이다. 이것을 사용하면 위젯 트리의 어디에서나 데이터를 손쉽게 공유할 수 있다.

### ChangeNotifier

`Provider`에서 응용 프로그램 상태를 캡슐화하기 위한 방법 중 하나로 `ChangeNotifier`를 사용한다.

이는 Flutter SDK에 포함된 간단한 클래스로, 리스너에게 변경 사항을 알리는 기능을 제공한다.

### ChangeNotifierProvider

자손에게 `ChangeNotifier`의 인스턴스를 제공하는 위젯으로, 필요한 곳 위에 `ChangeNotifierProvider`를 놓으면 된다. (`ChangeNotifierProvider`로 감싸준다.)

### Consumer

제공된 모델을 사용하여 UI를 업데이트한다.
`builder`는 `ChangeNotifier`가 변경될 때마다 호출되는 함수이다.

`builder`는 세 가지 인수를 받는다.

1. context
2. ChangeNotifier의 인스턴스
3. child

### Provider.of

`Provider.of`를 사용하면 모델의 데이터가 UI를 변경하지 않더라도 액세스할 수 있다.

즉, 필요하지 않은 위젯을 다시 빌드하는 불필요한 일을 하지 않고도 모델에 액세스할 수 있다.

## Riverpod

[[Flutter] 상태 관리 패키지 Riverpod 알아보기](https://seosh817.tistory.com/416#google_vignette)

`Riverpod`는 리액티브 캐싱, 데이터 바인딩 프레임워크로, `InheritedWidget`와 비슷한 동작을 하는 상태 관리 패키지이다.

Provider 패키지의 상위 버전 패키지로, 여러가지 장점이 있다.

1. Provider 사용에 문제가 있을 때 Compile Time에 오류를 발견하므로 Run Time에 `ProviderNotFoundException` 예외가 발생하지 않는다.
2. Flutter SDK에 의존하지 않아 Dart에서도 사용 가능하다.
3. 테스트 내에서 Provider를 재정의할 필요 없어 테스트가 쉬워진다.
4. 사용되지 않는 Provider의 State를 자동으로 dispose 시킨다.

## GetX

React에서 대표적인 상태관리 라이브러리로 Redux가 있다면, Flutter에서는 GetX를 사용한다.

### 기본 원칙

GetX에는 세 가지 기본 원칙이 있다.

#### 1. 성능

GetX는 성능과 최소한의 리소스 소비에 중점을 둔다. GetX는 `Streams`나 `ChangeNotifier`를 사용하지 않는다.

#### 2. 생산성

사용하기 쉽운 구문을 사용해 개발 시간을 절약하고 응용 프로그램이 제공할 수 있는 최대 성능을 제공한다.

#### 3. 조직화

View, 프레젠테이션 로직, 비즈니스 로직, 의존성 주입 및 네비게이션의 완전한 분리를 허용해 Route 간에 이동할 때 위젯 트리에 의존하지 않는다. GetX는 자체 의존성 주입 기능을 사용하여 이를 완전히 분리한다.

### 장점

GetX를 사용하면 응용 프로그램의 각 기능을 어디에서 찾을 수 있는지 알 수 있으며, 유지 관리를 쉽게한다.

또한 가볍고 실용적이며 확장 가능한 방식으로 Flutter SDK를 사용하여 고성능 응용 프로그램을 구축하는 가장 쉬운 방법이다.
