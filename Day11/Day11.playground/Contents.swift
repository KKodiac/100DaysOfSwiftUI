import Cocoa

/* How to limit access to internal data using access control */
// access controllers
// `private` -> no usage outside of Struct
// `fileprivate` -> no usage outside of current file
// `public` -> anyone
// `private(set) -> anyone read, only method write

struct BankAccount {
    private var funds = 0

    mutating func deposit(amount: Int) {
        funds += amount
    }

    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

// `private` access control -> most likely will require a initializer

/* Static properties and methods */
// `static` -> property with `static` keyword makes it belong to Struct itself instead of individual instance
struct School {
    static var studentCount = 0

    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}

// no instance required
School.add(student: "Taylor Swift")
print(School.studentCount)

// `Self` -> refer to current type(Int, Double, etc)
// `self` -> refer to current value

// Usage 1. Organize common data in app
struct AppData {
    static let version = "1.3 beta 2"
    static let saveFilename = "settings.json"
    static let homeURL = "https://www.hackingwithswift.com"
}

// Usage2. SwiftUI Preview, creating examples of structs
struct Employee {
    let username: String
    let password: String

    static let example = Employee(username: "cfederighi", password: "hairforceone")
}
