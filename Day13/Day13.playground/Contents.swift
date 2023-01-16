import Cocoa

/* How to create and use protocols */
protocol Vehicle {
    var name: String { get } // computed property - getter -> read
    var currentPassengers: Int { get set } // computed property - getter, setter -> read, write, no constant
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

// `Conforming to the protocol` -> Creating new structs, classes or enums that implement the protocol
struct Car: Vehicle {
    let name = "Car"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }
    
    func travel(distance: Int) {
        print("Drove \(distance)km")
    }
    
    func openSunroof() {
        print("It's a nice day!")
    }
}

// make it conform to Vehicle protocol
func commute(distance: Int, using vehicle: Vehicle) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("Too slow, try different commute type.")
    } else {
        vehicle.travel(distance: distance)
    }
}

let car = Car()
commute(distance: 100, using: car)

struct Bicycle: Vehicle {
    let name = "Bicycle"
    var currentPassengers = 1
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }
    
    func travel(distance: Int) {
        print("Cycling \(distance)km.")
    }
}

let bike = Bicycle()
commute(distance: 50, using: bike)

func getTravelEstimates(using vehicles: [Vehicle], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.name): \(estimate) hours to travel \(distance)km")
    }
}
getTravelEstimates(using: [car, bike], distance: 150)

/* How to use opaque return types */
// Int, Bool conform to `Equatable`
func getRandomNumber() -> Int {
    Int.random(in: 1...6)
}

func getRandomBool() -> Bool {
    Bool.random()
}
print(getRandomNumber() == getRandomNumber())

// Returning Equatable protocol,
// Int and Bool isn't interchangable
// Returning protocol hides information ->
// no exact type that is returned,
// instead focus on "functionality" that is returned

//func getRandomNumber() -> Equatable {
//    Int.random(in: 1...6)
//}
//
//func getRandomBool() -> Equatable {
//    Bool.random()
//}

// Opaque Return Type
// Allow hiding information of return types
func getRandomNumber() -> some Equatable {
    Int.random(in: 1...6)
}

func getRandomBool() -> some Equatable {
    Bool.random()
}

// Return Vehicle -> any sort of Vehicle type but don't know that
// Return some Vehicle -> a specific sort of Vehicle type but don't want to say which one
// SwiftUI uses `some View` as an example

/* How to create and use extensions */
extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func trim(_ string: String) -> String {
        string.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    mutating func trim() {
        self = self.trimmed()
    }
    
    var lines: [String] {
        self.components(separatedBy: .newlines)
    }
}
var quote = "   The truth is rarely pure and never simple   "
let trimmed = quote.trimmingCharacters(in: .whitespacesAndNewlines)

let trimmed = quote.trimmed()
let trimmed2 = trim(quote)

quote.trim()
let lyrics = """
But I keep cruising
Can't stop, won't stop moving
It's like I got this music in my mind
Saying it's gonna be alright
"""

print(lyrics.lines.count)
struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int
}

let lotr = Book(title: "Lord of the Rings", pageCount: 1178, readingHours: 24)

struct Book {
    let title: String
    let pageCount: Int
    let readingHours: Int

    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}

extension Book {
    init(title: String, pageCount: Int) {
        self.title = title
        self.pageCount = pageCount
        self.readingHours = pageCount / 50
    }
}
/* How to create and use protocol extensions */

let guests = ["Mario", "Luigi", "Peach"]

if guests.isEmpty == false {
    print("Guest count: \(guests.count)")
}
if !guests.isEmpty {
    print("Guest count: \(guests.count)")
}
extension Array {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
if guests.isNotEmpty {
    print("Guest count: \(guests.count)")
}
extension Collection {
    var isNotEmpty: Bool {
        isEmpty == false
    }
}
protocol Person {
    var name: String { get }
    func sayHello()
}
extension Person {
    func sayHello() {
        print("Hi, I'm \(name)")
    }
}
struct Employee: Person {
    let name: String
}
let taylor = Employee(name: "Taylor Swift")
taylor.sayHello()
