import Cocoa

/* How to provide default values for parameters */

func printTimesTables(for number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)

 Parameter with default value should come after ones without
func printTimesTables(for number: Int, end: Int = 12) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 5, end: 20)
printTimesTables(for: 8)

var characters = ["Lana", "Pam", "Ray", "Sterling"]
print(characters.count)
//characters.removeAll()
//print(characters.count)

// capacity 4
characters.removeAll(keepingCapacity: true)
print(characters.capacity)

/* How to handle errors in functions */

// Steps for error handling
// 1. Telling Swift about the possible rrors that can happen
// 2. Write a function that can flag up errors if they happen
// 3. Calling that function, and handling any errors that might happen

enum PasswordError: Error {
    case short, obvious
}

func checkPassword(_ password: String) throws -> String {
    if password.count < 5 {
        throw PasswordError.short
    }
    if password == "12345" {
        throw PasswordError.obvious
    }
    if password.count < 8 {
            return "OK"
        } else if password.count < 10 {
            return "Good"
        } else {
            return "Excellent"
        }
}

let string = "12345"

do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch {
    print("There was an error.")
}

let string = "12345"

// Catching individual errors
do {
    let result = try checkPassword(string)
    print("Password rating: \(result)")
} catch PasswordError.short {
    print("Please use a longer password.")
} catch PasswordError.obvious {
    print("I have the same combination on my luggage!")
} catch {
    print("There was an error.")
}
