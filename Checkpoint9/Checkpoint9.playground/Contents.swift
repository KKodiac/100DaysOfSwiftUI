import Cocoa

/* write a function that accepts an optional array of integers,
 and returns one randomly.
 If the array is missing or empty, return a random number in the range 1 through 100. */

func randomInteger(numberArray: [Int]?) -> Int {
    guard let numberArray = numberArray,
          let randomNumber = numberArray.randomElement() else {
        return Int.random(in: 1...100)
    }
    return randomNumber
}

let randomNumberNil = randomInteger(numberArray: nil)
let intArray: [Int] = Array(101...200)
let randomNumber = randomInteger(numberArray: intArray)
print(randomNumberNil)
print(randomNumber)
