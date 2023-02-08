# State Management

Created: February 8, 2023 11:29 AM

@State 

일반적인 View 안에 property의 상태를 확인할 때 사용한다. 여기서 참고할 점은 `struct` 랑`class` 로 property type을 정의하면 일어난다. 

```swift
struct User {
	var name: String
	var email: String
}

class User {
	var name: String
	var email: String
}
```

Struct 로 정의를 하면 struct 자체가 constant property이기 때문에 @State 를 사용해 상태를 확인하면 SwiftUI에서 변화를 감지하여 View가 다시 그려진다. 

```swift
let user = User() // Struct
user.name = "John"
user.email = "JohnTheBaptist@church.com"
```

라고 변화를 주변 User() 내부에 있는 property 를 새로 정의하면서 User 객체가 새로 생성되기 때문이다. 기존에 정의된 User property 가 파괴되고 새로운 내부 property 가 정의된 새로운 User 객체가 생성되어 지정되기 때문에 SwiftUI 상에서는 이를 변화로 감지하고 View를 새로 그린다.

하지만 Class 로 정의한 User() 은 기존에 참조하고 있던 User 객체에 있던 내부 property 를 새로 정의하기 때문에 User 객체로만 보았을 때 변화가 일어나지 않는다. 따라서 내부 property 변화는 있더라도 View는 **새로 그려지지 않는다.**

@StateObject  vs @ObservedObject

```swift
class StateChangingObject: ObservableObject {
	@Published var stateOne: Int
	@PUblished var stateTwo: String
}

struct SomeView: View {
	@StateObject var stateChangingObjectState: StateChangingObject
	@ObservedOject var stateChangingObjectObserved: StateChangingObject 
	var body: some View {
		// some random code
	}
}
```

Class 객체 내부 property 의 변화를 View 에 알려주기 위해서는 해당 Class를 observable object 로 comform 하게 하고, 내부 property 를 @Published wrapper 로 감싸주면 된다. 그 후 View 내부에서 해당 객체들의 정의를 할때 사용할 수 있는 방법이 두가지 있다. 

*StateObject*

*ObservedObject*

사실 그냥 사용하면 둘의 차이를 못 느낄 수 있다. Property 의 상태 변화가 감지 되어 둘 다 View 가 다시 그려지기 때문이다. 하지만 여기서 중요한 점은 StateObject 는 View 가 다시 그려져도 해당 객체의 상태를 유지한다는 점이다. 아래 참고한 글의 예시를 보면 자세히 알 수 있다. 

**따라서 StateObject는 해당 property 가 정의된 View 가 다시 그려져도 상태를 기억할 수 있도록 유지하기 위해 상태 객체의 정의를 해줄 때 사용하는 것이 맞으며, ObservedObject 는 다른 View 에 해당 property 를 주입할 때 사용하는 것이 맞다.** 

**참고한 글**

[@StateObject vs. @ObservedObject: The differences explained](https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/)

@AppStorage

@State + UserDefaults. 값의 상태 변화를 UserDefaults 키 값을 통해 앱 저장소 내부에 저장한다.