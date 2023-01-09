import Cocoa

/* How to use a for loop to repeat work */

let platforms = ["iOS", "MacOS", "tvOS", "watchOS"]

for os in platforms {
    print("Swift works great on \(os).")
}

for name in platforms {
    print("Swift works great on \(name).")
}

// iterating itegers
for i in 1...12 {
    print("5 x \(i) is \(5 * i)")
}

for i in 1..<5 {
    print("Counting 1 up to 5: \(i)")
}

var lyrics = "Haters gonna"

for _ in 1...5 {
    lyrics += "hate"
}

print(lyrics)


/* How to use a while loop to repeat work */
var countdown = 10

while countdown > 0 {
    print("\(countdown)")
    countdown -= 1
}

let id = Int.random(in: 1...1000)
let amount = Double.random(in: 0...1)

var roll = 0
while roll != 20 {
    roll = Int.random(in: 1...20)
    print("Rolled \(roll)")
}
print("Stopped due to rolling 20!")

/* How to skip loop items with break and continue */

// continue
let filenames = ["me.jpg", "work.txt", "sophie.jpg", "logo.psd"]

for filename in filenames {
    if filename.hasSuffix(".jpg") == false {
        continue
    }
    print("Found picture: \(filename)")
}

// break
let number1 = 4
let number2 = 14
var multiples = [Int]()

for i in 1...100_000 {
    if i.isMultiple(of: number1) && i.isMultiple(of: number2) {
        multiples.append(i)

        if multiples.count == 10 {
            break
        }
    }
}

print(multiples)
