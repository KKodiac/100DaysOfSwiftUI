import Cocoa

/* MARK: How to create variables and constants */

var greeting = "Hello, playground"

var name = "Ted"
name = "Rebecca"
name = "Keeley"

let character = "Daphne"
//character = "Eloise"
//character = "Francesca"

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

let managerName = "Michael Scott"
let dogBreed = "Samoyed"
let meaningOfLife = "How many roads must a man walk down?"


/* MARK: How to create variables and constants */

let actor = "Denzel Washington"
let filename = "paris.jpg"
let result = "🤓너디맨🤓"

let quote = "Then he tapped a sign saying \"Believe\" and walked away."

let movie = """
A day in
the life of an
Apple Engineer
"""

print(actor.count)

let nameLength = actor.count
print(nameLength)

print(filename.uppercased())
print(movie.hasPrefix("A day"))
print(filename.hasSuffix(".jpg"))


/* MARK: How to store whole numbers */

let score = 10
let reallyBigNumber = 100_000_000

let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)

var counter = 10
counter = counter + 5
counter += 5
print(counter)

counter *= 2
print(counter)
counter -= 10
print(counter)
counter /= 2
print(counter)

let number = 120
print(number.isMultiple(of: 3))

print(120.isMultiple(of: 3))

/* MARK: How to store decimal numbers */

let numberDouble = 0.1 + 0.2
print(numberDouble)

let a = 1
let b = 2.0
// let c = a + b
let c = a + Int(b)
let d = Double(a) + b

let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3

var actorName = "Nicolas Cage"
actorName = "John Travolta"
//var name = "Nicolas Cage"
//name = 57

var rating = 5.0
rating *= 2

