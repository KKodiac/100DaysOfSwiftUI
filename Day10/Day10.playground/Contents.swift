import Cocoa

/* How to create your own structs */
//
//struct Album {
//    let title: String
//    let artist: String
//    let year: Int
//
//    func printSummary() {
//        print("\(title) (\(year)) by \(artist)")
//    }
//}
//
//let red = Album(title: "Red", artist: "Taylor Swift", year: 2012)
//let wings = Album(title: "Wings", artist: "BTS", year: 2016)
//
//print(red.title)
//print(wings.artist)
//
//red.printSummary()
//wings.printSummary()
//
//
//// `mutating` keyword is used to indicate functions that can change data
//struct Employee {
//    let name: String
//    var vacationRemaining: Int
//
//    mutating func takeVacation(days: Int) {
//        if vacationRemaining > days {
//            vacationRemaining -= days
//            print("I'm going on vacation!")
//            print("Days remaining: \(vacationRemaining)")
//        } else {
//            print("Oops! There aren't enough days remaining.")
//        }
//    }
//}
//
//// Struct defined as `let` makes all of its inner data constant
//var archer = Employee(name: "Sterling Archer", vacationRemaining: 14)
//archer.takeVacation(days: 5)
//print(archer.vacationRemaining)
//
//// `properties` -> vars and consts that belong to a Struct
//// `methods` -> functions that belong to a Struct
//// `instance` -> instance of a Struct "var archer"
//// 'initializer` -> Init function of an instance
//
//var archer1 = Employee(name: "Sterling Archer", vacationRemaining: 14)
//var archer2 = Employee.init(name: "Sterling Archer", vacationRemaining: 14)
//
//
//
//// `mutating` keyword is used to indicate functions that can change data
//struct Employee {
//    let name: String
//    var vacationRemaining: Int = 14
//
//
//    mutating func takeVacation(days: Int) {
//        if vacationRemaining > days {
//            vacationRemaining -= days
//            print("I'm going on vacation!")
//            print("Days remaining: \(vacationRemaining)")
//        } else {
//            print("Oops! There aren't enough days remaining.")
//        }
//    }
//}
//
//let kane = Employee(name: "Lana Kane")
//let poovey = Employee(name: "Pam Poovey", vacationRemaining: 35)

/* How to compute property values dynamically */

// `stored property`
// `computed property`
struct Employee {
    // `stored property`
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0

    // `computed property`
    var vacationRemaining: Int {
        get { // called when property is called
            vacationAllocated - vacationTaken
        }

        set { // called when property is set
            vacationAllocated = vacationTaken + newValue
        }
    }}
var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
archer.vacationRemaining = 5
print(archer.vacationAllocated)

/* How to take action when a property changes */
// `didSet` -> observer to run when property value changes
// `willSet` -> observer to run before the property changes
struct Game {
    var score = 0 {
        didSet {
            print("Score is now \(score): [didSet]")
        }
    }
}


var game = Game()
game.score += 10
game.score -= 3
print("Score is now \(game.score)")
game.score += 1

struct App {
    var contacts = [String]() {
        // newValue -> constant to utilize when wanting to use value after change
        willSet {
            print("Current value is: \(contacts)")
            print("New value will be: \(newValue)")
        }
        
        // oldValue -> constant to utilize when wanting to use value from before change
        didSet {
            print("There are now \(contacts.count) contacts.")
            print("Old value was \(oldValue)")
        }
    }
}

var app = App()
app.contacts.append("Adrian E")
app.contacts.append("Allen W")
app.contacts.append("Ish S")

/* How  to create custom initializers */
struct Player {
    let name: String
    let number: Int

    init(name: String, number: Int) {
        self.name = name
        self.number = number
    }
}
