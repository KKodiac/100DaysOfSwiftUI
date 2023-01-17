import Cocoa

/* How to handle missing data with optionals */
let opposites: [String: String] = [
    "Mario": "Wario",
    "Luigi": "Waluigi"
]

let peachOpposite = opposites["Peach"]
print(type(of: peachOpposite))

if let marioOpposite = opposites["Mario"] {
    print("Mario's opposite is \(marioOpposite)")
}

var username: String? = nil

if let unwrappedName = username {
    print("We got a user: \(unwrappedName)")
} else {
    print("The optional was empty.")
}

// Optionals -> Data may or may not be present
// Non-Optionals -> Data MUST be present
// Zev Eisenberg: "Swift didn't introduce optionals. It introduced non-optionals

func square(number: Int) -> Int {
    number * number
}

var number: Int? = nil


// unwrap
if let unwrappedNumber = number {
    print(square(number: unwrappedNumber))
}
if let number = number {
    print(square(number: number)) // can't use optional where non-optionals is needed
}

/* How to unwrap optionals with guard */
func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")
        return
    }

    print("\(number) x \(number) is \(number * number)")
}

var myVar: Int? = 3

if let unwrapped = myVar {
    print("Run if myVar has a value inside")
}

guard let unwrapped = myVar else {
    print("Run if myVar doesn't have a value inside")
}

func printSquare(of number: Int?) {
    guard let number = number else {
        print("Missing input")

        // 1: We *must* exit the function here
        return
    }

    // 2: `number` is still available outside of `guard`
    print("\(number) x \(number) is \(number * number)")
}

guard someArray.isEmpty else { return }

/* How to unwrap optionals with nil coalescing */
let captains = [
    "Enterprise": "Picard",
    "Voyager": "Janeway",
    "Defiant": "Sisko"
]

let new = captains["Serenity"]

// nil coalescing operator: `??`
// provides default value for any optional
let new = captains["Serenity"] ?? "N/A"
let new = captains["Serenity", default: "N/A"] // same thing

let tvShows = ["Archer", "Babylon 5", "Ted Lasso"]
let favorite = tvShows.randomElement() ?? "None"

struct Book {
    let title: String
    let author: String?
}

let book = Book(title: "Beowulf", author: nil)
let author = book.author ?? "Anonymous"
print(author)

let input = ""
let number = Int(input) ?? 0
print(number)

/* How to handle multiple optionals using optional chaining */
let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")

struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil
let author = book?.author?.first?.uppercased() ?? "A"
print(author)

/* How to handle function failure with optionals */

// try! -> certain the function will not fail
// should be used rarely
enum UserError: Error {
    case badID, networkFailed
}

func getUser(id: Int) throws -> String {
    throw UserError.networkFailed
}

if let user = try? getUser(id: 23) {
    print("User: \(user)")
}

// `try?` used under...
// 1. In combination with `guard let` to exit the current function if the try? call returns nil.
// 2. In combination with nil coalescing to attempt something or provide a default value on failure
// 3. When calling any throwing function without a return value -> genuinely don't care if it succeeded or not 
