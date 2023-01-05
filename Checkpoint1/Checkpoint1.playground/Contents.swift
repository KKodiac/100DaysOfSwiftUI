import Cocoa

/* 조건 요구 사항
 
1. 섭씨를 값으로 갖는 상수를 생성해라.
2. 섭씨에 9를 곱하고, 5를 나눈 후, 32를 더해서 화씨로 변형해라.
3. 섭씨와 화씨 값을 사용자를 위해 출력해라.
 */

let celsius: Float = 32
let fahrenheit: Float = celsius * 9 / 5 + 32

print("\(celsius)°C is equivalent to \(fahrenheit)°F")
