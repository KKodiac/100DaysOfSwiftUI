import Cocoa

/* How to create your own classes */


/*
 
1. You can make one class build upon functionality in another class, gaining all its properties and methods as a starting point. If you want to selectively override some methods, you can do that too.

2. Because of that first point, Swift won’t automatically generate a memberwise initializer for classes. This means you either need to write your own initializer, or assign default values to all your properties.
3. When you copy an instance of a class, both copies share the same data – if you change one copy, the other one also changes.
4. When the final copy of a class instance is destroyed, Swift can optionally run a special function called a deinitializer.
5. Even if you make a class constant, you can still change its properties as long as they are variables.
 */
class Game {
    var score = 0 {
        didSet {
            print("Score is now \(score)")
        }
    }
}

var newGame = Game()
newGame.score += 10

/* How to make on class inherit from another */
class Employee {
    let hours: Int
    
    init(hours: Int) {
        self.hours = hours
    }
    func printSummary() {
        print("I work \(hours) hours a day.")
    }
}

class Developer: Employee {
    func work() {
        print("I'm writing code for \(hours) hours.")
    }
    
    
    // `override`
    override func printSummary() {
        print("I'm a developer who will sometimes work \(hours) hours a day, but other times spend hours arguing about whether code should be indented using tabs or spaces.")
    }
}

class Manager: Employee {
    func work() {
        print("I'm going to meetings for \(hours) hours.")
    }
}

// Employee as a super class
let robert = Developer(hours: 8)
let joseph = Manager(hours: 10)
robert.work()
joseph.work()

let novall = Developer(hours: 8)
novall.printSummary()


/* How to add initializers for classes */
class Vehicle {
    let isElectric: Bool

    init(isElectric: Bool) {
        self.isElectric = isElectric
    }
}

class Car: Vehicle {
    let isConvertible: Bool

    // Super initialization when passing on property to parent class
    init(isElectric: Bool, isConvertible: Bool) {
        self.isConvertible = isConvertible
        super.init(isElectric: isElectric)
    }
}

let teslaX = Car(isElectric: true, isConvertible: false)
// If a subclass does not have any of its own initializers,
// it automatically inherits the initializers of its parent class.


/* How to copy as class */
// Classes are "reference types"
class User {
    var username = "Anonymous"
}

var user1 = User()
var user2 = user1
user2.username = "Taylor"
print(user1.username)
print(user2.username)

// "Deep Copy" -> Unique copy of a class instance
class User {
    var username = "Anonymous"

    func copy() -> User {
        let user = User()
        user.username = username
        return user
    }
}

/* How to create a deinitializer for a class */
class User {
    let id: Int

    init(id: Int) {
        self.id = id
        print("User \(id): I'm alive!")
    }

    // called when class instance is garbage collected
    deinit {
        print("User \(id): I'm dead!")
    }
}

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
}

var users = [User]()

for i in 1...3 {
    let user = User(id: i)
    print("User \(user.id): I'm in control!")
    users.append(user)
}

print("Loop is finished!")
users.removeAll()
print("Array is clear!")

/* How to work wth varable inside classes */
class User {
    var name = "Paul"
}

let user = User()
user.name = "Taylor"
print(user.name)

class User {
    var name = "Paul"
}

var user = User()
user.name = "Taylor"
user = User()
print(user.name)

// no need for `mutating` 
