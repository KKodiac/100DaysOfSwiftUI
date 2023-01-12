import Cocoa

/* How to create and use closure */
func greetUser() {
    print("Hi there!")
}

greetUser()

var greetCopy = greetUser
greetCopy()

// Closure => Anonymous functions that take no parameters and return no value
let sayHello = {
    print("Hi there!")
}

sayHello()

// Closure => with parameters
let sayHello = { (name: String) -> String in
    "Hi \(name)!"
}

// Reason why Closure is important 1: Function Types
var greetCopy: () -> Void = greetUser
// name of closure: empty param -> return type(nothing) =

// Function Type does not pass on names of data(i.e. parameter names)
func getUserData(for id: Int) -> String {
    if id == 1989 {
        return "Taylor Swift"
    } else {
        return "Anonymous"
    }
}

let data: (Int) -> String = getUserData
let user = data(1989)
print(user)
// getUserData(for(parameter name)) doesn't get passed on to closure "data"

let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let sortedTeam = team.sorted()
print(sortedTeam)

func captainFirstSorted(name1: String, name2: String) -> Bool {
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}

// Usage of custom sorting function "captainFirstSorted"
let captainFirstTeam = team.sorted(by: captainFirstSorted)
print(captainFirstTeam)

// Usage of custom sorting function passed in as closure
let captainFirstTeam = team.sorted(by: { (name1: String, name2: String) -> Bool in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

/* How to use trailing closures and shrthand syntax */
// Trailing Closure syntax
let captainFirstTeam = team.sorted(by: { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
})

let captainFirstTeam = team.sorted {
    if $0 == "Suzanne" {
        return true
    } else if $1 == "Suzanne" {
        return false
    }
    return $0 < $1
}

let reverseTeam = team.sorted {
    return $0 > $1
}

let reverseTeam = team.sorted { $0 > $1 }
let tOnly = team.filter { $0.hasPrefix("T") }
print(tOnly)

let uppercaseTeam = team.map { $0.uppercased() }
print(uppercaseTeam)

/* How to accept functions as parameters */
//  name        parameter 1, parameter 2{(function)->returns Int} -> return [Int]
func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}

let rolls = makeArray(size: 50) {
    Int.random(in: 1...20)
}

print(rolls)


func generateNumber() -> Int {
    Int.random(in: 1...20)
}

let newRolls = makeArray(size: 50, using: generateNumber)
print(newRolls)

// parameters as functions
func doImportantWork(first: () -> Void, second: () -> Void, third: () -> Void) {
    print("About to start first work")
    first()
    print("About to start second work")
    second()
    print("About to start third work")
    third()
    print("Done!")
}

// passing parameter functions in closure
doImportantWork {
    print("This is the first work")
} second: {
    print("This is the second work")
} third: {
    print("This is the third work")
}

// 이건 뭐냐...
// travel returns Anonymous function (String) which returns Void
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel()
result("London")

