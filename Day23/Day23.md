# SwiftUI View

Created: January 26, 2023 4:39 PM

- `ViewModifier` → View에 종속된 `ModifiedContent` struct를 계속 연장함
    
    ```swift
    Button("Hello, world!") {
        print(type(of: self.body))
    }    
    .background(.red)
    .frame(width: 200, height: 200)
    
    ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>
    ```
    
    그래서 ViewModifier의 순서가 중요하게 됩니다.
    

- `some View` → “`View` protocol을 구현하는 애들 중에서 누군가는 반환한다.”
    
     SwiftUI는 View에 대해서는 관심 없고 내부에 어떤 타입인지 궁금해함.
    

- `VStack` → `VStack` 안에 다른 View 세개를 넣는다면, SwiftUI가 몰래 `TupleView` 라는 것을 생성한다. `TupleView` 중에서 2개, 3개, 4개 … 10개의 View를 저장하는 형태가 있는데, 그래서 `VStack` 은 10개를 초과하는 View를 담지 못한다.
    
    ```swift
    TupleView<(C0, C1)>
    TupleView<(C0, C1, C3)>
    TupleView<(C0, C1, C3, C4)>
    ...
    TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)> 까지만 SwiftUI에서 구현해놈
    ```
    

- `var body` 안에서 뷰 스택 없이 여러개의 View를 넣으면? → `@ViewBuilder` 라는 프라퍼니 래퍼를 SwiftUI에서 몰래 `body` 에 적용함. 따라서 이 여러개의 View들은 하나의 `TupleView` 에 합쳐져서 하나의 `View` 로 반환됨. `body` 프라퍼티의 구현을 보면:
    
    ```swift
    @ViewBuilder var body: Self.Body { get }
    ```
    
    로 되어 있으며, `@ViewBuilder` 에 래핑된 것을 볼 수 있음.
    

- `ternary conditional operator` → 조건문을 통해 View의 상태를 변형해야 될 때 웬만하면 `ternary` 를 사용하자.
    
    ```swift
    struct ContentView: View {
        @State private var useRedText = false
    
        var body: some View {
            Button("Hello World") {
                // flip the Boolean between true and false
                useRedText.toggle()            
            }
            .foregroundColor(useRedText ? .red : .blue)
        }
    }
    ```
    
    ```swift
    var body: some View {
        if useRedText {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundColor(.red)
        } else {
            Button("Hello World") {
                useRedText.toggle()
            }
            .foregroundColor(.blue)
        }
    }
    ```
    
    위 처럼 if문을 사용하면, SwiftUI에서는 우선 Button View 두개를 생성하며, 상태에 따라 둘 중 하나를 파괴하는 순서를 띈다. Ternary 방식을 택하면 Button View 하나만 생성한다.
    

- Environment Modifiers → VStack 전체에 적용 가능한 view modifier을 environement modifier라고 부른다.
    
    여기서 참고할 점은 내부 자식에 적용된 view modifier가 우선으로 적용된다. 예를 들어 `font` 가 있다. 대신 그렇지 않은 일반 modifier도 있어서(`blur` 처럼) 스택 전체에 해당되는지, 안되는 지는 문서를 잘 찾아보자.
    
- Custom Modifiers
    
    **Tip:** 새로운 View Modifier을 정의 vs 새로운 메서드를 `View` 에 추가하기
    
    해당 여부를 고려할때 생각할 점:
    
    **새로운 View Modifier은 각자의 stored property를 갖을 수 있습니다.**
    
    ```swift
    struct Title: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    extension View {
        func titleStyle() -> some View {
            modifier(Title())
        }
    }
    
    Text("Hello World")
        .titleStyle()
    ```
    

- Custom Containers
    
    ```swift
    struct GridStack<Content: View>: View {
        let rows: Int
        let columns: Int
        let content: (Int, Int) -> Content
    
        var body: some View {
    	    VStack {
    	        ForEach(0..<rows, id: \.self) { row in
    	            HStack {
    	                ForEach(0..<columns, id: \.self) { column in
    	                    content(row, column)
    	                }
    	            }
    	        }
    	    }
    	}
    }
    ```